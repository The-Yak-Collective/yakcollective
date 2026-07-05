import path from "node:path";
import fs from "node:fs/promises";
import type { Root } from "hast";
import type {
  GlobalConfiguration,
  QuartzEmitterPlugin,
  BuildCtx,
  FilePath,
  FullSlug,
  QuartzPluginData,
  ProcessedContent,
  SimpleSlug,
} from "@quartz-community/types";
import { joinSegments } from "@quartz-community/types";
import { simplifySlug, escapeHTML } from "@quartz-community/utils";
import { getDate } from "@quartz-community/utils/sort";
import { toHtml } from "hast-util-to-html";

export type ContentIndexMap = Map<FullSlug, ContentDetails>;
export type ContentDetails = {
  slug: FullSlug;
  filePath: FilePath;
  title: string;
  links: SimpleSlug[];
  tags: string[];
  content: string;
  richContent?: string;
  date?: Date;
  description?: string;
  frontmatterDate?: string;
};

interface Options {
  enableSiteMap: boolean;
  enableRSS: boolean;
  rssLimit?: number;
  rssFullHtml: boolean;
  rssSlug: string;
  includeEmptyFiles: boolean;
  rssRecentNotesText?: string;
  rssLastFewNotesText?: (count: number) => string;
}

const defaultOptions: Options = {
  enableSiteMap: true,
  enableRSS: true,
  rssLimit: 10,
  rssFullHtml: false,
  rssSlug: "index",
  includeEmptyFiles: true,
  rssRecentNotesText: "Recent notes",
  rssLastFewNotesText: (count) => `Last ${count} notes`,
};

const write = async (args: {
  ctx: BuildCtx;
  content: string;
  slug: FullSlug;
  ext: string;
}): Promise<FilePath> => {
  const pathToPage = joinSegments(args.ctx.argv.output, args.slug + args.ext) as FilePath;
  const dir = path.dirname(pathToPage);
  await fs.mkdir(dir, { recursive: true });
  await fs.writeFile(pathToPage, args.content);
  return pathToPage;
};

function generateSiteMap(cfg: GlobalConfiguration, idx: ContentIndexMap): string {
  const base = cfg.baseUrl ?? "";
  const createURLEntry = (slug: SimpleSlug, content: ContentDetails): string => `<url>
    <loc>https://${joinSegments(base, encodeURI(slug)).replace(/\/+$/, "/")}</loc>
    ${content.date && `<lastmod>${content.date.toISOString()}</lastmod>`}
  </url>`;
  const urls = Array.from(idx)
    .map(([slug, content]) => createURLEntry(simplifySlug(slug) as SimpleSlug, content))
    .join("");
  return `<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xhtml="http://www.w3.org/1999/xhtml">${urls}</urlset>`;
}

function generateRSSFeed(
  cfg: GlobalConfiguration,
  idx: ContentIndexMap,
  options: Options,
  limit?: number,
): string {
  const base = cfg.baseUrl ?? "";
  const pageTitle = cfg.pageTitle ?? "";
  const recentNotesText = options.rssRecentNotesText ?? "Recent notes";
  const lastFewNotesText =
    options.rssLastFewNotesText ?? ((count: number) => `Last ${count} notes`);

  const createURLEntry = (slug: SimpleSlug, content: ContentDetails): string => `<item>
    <title>${escapeHTML(content.title)}</title>
    <link>https://${joinSegments(base, encodeURI(slug))}</link>
    <guid>https://${joinSegments(base, encodeURI(slug))}</guid>
    <description><![CDATA[ ${content.richContent ?? content.description} ]]></description>
    <pubDate>${content.date?.toUTCString()}</pubDate>
  </item>`;

  const items = Array.from(idx)
    .filter(([_, content]) => content.frontmatterDate)
    .sort(([_, f1], [__, f2]) => {
      if (f1.date && f2.date) {
        return f2.date.getTime() - f1.date.getTime();
      } else if (f1.date && !f2.date) {
        return -1;
      } else if (!f1.date && f2.date) {
        return 1;
      }

      return f1.title.localeCompare(f2.title);
    })
    .map(([slug, content]) => createURLEntry(simplifySlug(slug) as SimpleSlug, content))
    .slice(0, limit ?? idx.size)
    .join("");

  const description = `${
    limit ? lastFewNotesText(limit) : recentNotesText
  } on ${escapeHTML(pageTitle)}`;

  return `<?xml version="1.0" encoding="UTF-8" ?>
<rss version="2.0">
    <channel>
      <title>${escapeHTML(pageTitle)}</title>
      <link>https://${base}</link>
      <description>${description}</description>
      <generator>Quartz -- quartz.jzhao.xyz</generator>
      ${items}
    </channel>
  </rss>`;
}

export const ContentIndex: QuartzEmitterPlugin<Partial<Options>> = (opts) => {
  const options = { ...defaultOptions, ...opts };
  const emitAll = async (ctx: BuildCtx, content: ProcessedContent[]): Promise<FilePath[]> => {
    const cfg = ctx.cfg.configuration;
    const linkIndex: ContentIndexMap = new Map();
    for (const [tree, file] of content) {
      const data = (file.data as Record<string, unknown>) ?? {};
      if (data.unlisted === true) continue;
      const slug = data.slug as FullSlug;
      const date = getDate(data as QuartzPluginData) ?? new Date();
      const text = data.text as string | undefined;
      if (options.includeEmptyFiles || (text && text !== "")) {
        const frontmatter = (data.frontmatter as Record<string, unknown> | undefined) ?? {};
        const isEncrypted = data.encrypted === true;
        linkIndex.set(slug, {
          slug,
          filePath: data.relativePath as FilePath,
          title: (frontmatter.title as string) ?? "",
          links: (data.links as SimpleSlug[] | undefined) ?? [],
          tags: (frontmatter.tags as string[] | undefined) ?? [],
          content: text ?? "",
          richContent:
            options.rssFullHtml && !isEncrypted
              ? escapeHTML(toHtml(tree as Root, { allowDangerousHtml: true })).replace(/href=\&quot;(\.\.\/)+/g, `href=&quot;https://${cfg.baseUrl}/`)
              : undefined,
          date: date,
          description: (data.description as string | undefined) ?? "",
          frontmatterDate: data.frontmatter?.date,
        });
      }
    }

    const outputs: FilePath[] = [];
    if (options.enableSiteMap) {
      outputs.push(
        await write({
          ctx,
          content: generateSiteMap(cfg, linkIndex),
          slug: "sitemap" as FullSlug,
          ext: ".xml",
        }),
      );
    }

    if (options.enableRSS) {
      outputs.push(
        await write({
          ctx,
          content: generateRSSFeed(cfg, linkIndex, options, options.rssLimit),
          slug: (options.rssSlug ?? "index") as FullSlug,
          ext: ".xml",
        }),
      );
    }

    const fp = joinSegments("static", "contentIndex") as unknown as FullSlug;
    const simplifiedIndex = Object.fromEntries(
      Array.from(linkIndex).map(([slug, content]) => {
        delete content.description;
        delete content.date;
        return [slug, content];
      }),
    );

    outputs.push(
      await write({
        ctx,
        content: JSON.stringify(simplifiedIndex),
        slug: fp,
        ext: ".json",
      }),
    );

    return outputs;
  };

  return {
    name: "ContentIndex",
    emit: (ctx, content) => emitAll(ctx, content),
    // RSS auto-discovery link tag should be added via a component plugin or manually in the layout.
    partialEmit: (ctx, content) => emitAll(ctx, content),
  };
};
