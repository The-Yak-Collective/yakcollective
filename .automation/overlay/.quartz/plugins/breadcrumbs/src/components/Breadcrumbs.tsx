import type {
  QuartzComponent,
  QuartzComponentConstructor,
  QuartzComponentProps,
} from "@quartz-community/types";
import { classNames } from "../util/lang";
import { resolveRelative, simplifySlug } from "../util/path";
import { FileTrieNode, trieFromAllFiles } from "../util/fileTrie";
import style from "./styles/breadcrumbs.scss";

type CrumbData = {
  displayName: string;
  path: string;
};

export interface BreadcrumbOptions {
  /** Symbol between crumbs */
  spacerSymbol: string;
  /** Name of first crumb */
  rootName: string;
  /** Whether to look up frontmatter title for folders */
  resolveFrontmatterTitle: boolean;
  /** Whether to display the current page in the breadcrumbs */
  showCurrentPage: boolean;
}

const defaultOptions: BreadcrumbOptions = {
  spacerSymbol: "❯",
  rootName: "Home",
  resolveFrontmatterTitle: true,
  showCurrentPage: true,
};

function formatCrumb(displayName: string, baseSlug: string, currentSlug: string): CrumbData {
  return {
    displayName,
    path: resolveRelative(baseSlug, currentSlug),
  };
}

export default ((opts?: Partial<BreadcrumbOptions>) => {
  const options: BreadcrumbOptions = { ...defaultOptions, ...opts };
  const Breadcrumbs: QuartzComponent = ({
    fileData,
    allFiles,
    displayClass,
    ctx,
  }: QuartzComponentProps) => {
    const typedCtx = (ctx ?? {}) as Record<string, unknown> as { trie?: FileTrieNode };
    typedCtx.trie ??= trieFromAllFiles(
      allFiles as Array<{
        slug?: string;
        filePath?: string;
        frontmatter?: { title?: string; [key: string]: unknown };
      }>,
    );
    const trie = typedCtx.trie;
    const slug = fileData.slug as string;
    const slugParts = slug.split("/");
    const pathNodes = trie.ancestryChain(slugParts);

    if (!pathNodes) {
      return (
        <nav class={classNames(displayClass, "breadcrumb-container")} aria-label="breadcrumbs">
          <div class="breadcrumb-element">
            <a href={"../".repeat(slugParts.length - 1)}>{options.rootName}</a>
            <p>{` ${options.spacerSymbol} `}</p>
          </div>
          {slugParts.map((crumb, index) => (
            <div class="breadcrumb-element">
              <a href={"../".repeat(slugParts.length - 1) + slugParts.slice(0,index + 1).join("/")}>{crumb}</a>
              {index !== slugParts.length - 1 && <p>{` ${options.spacerSymbol} `}</p>}
            </div>
          ))}
        </nav>
      )  
    }

    const crumbs: CrumbData[] = pathNodes.map((node, idx) => {
      const crumb = formatCrumb(node.displayName, slug, simplifySlug(node.slug));
      if (idx === 0) {
        crumb.displayName = options.rootName;
      }

      if (idx === pathNodes.length - 1) {
        crumb.path = "";
      }

      return crumb;
    });

    if (!options.showCurrentPage) {
      crumbs.pop();
    }

    return (
      <nav class={classNames(displayClass, "breadcrumb-container")} aria-label="breadcrumbs">
        {crumbs.map((crumb, index) => (
          <div class="breadcrumb-element">
            <a href={crumb.path}>{crumb.displayName}</a>
            {index !== crumbs.length - 1 && <p>{` ${options.spacerSymbol} `}</p>}
          </div>
        ))}
      </nav>
    );
  };
  Breadcrumbs.css = style;

  return Breadcrumbs;
}) satisfies QuartzComponentConstructor;
