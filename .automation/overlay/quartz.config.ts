import { QuartzConfig } from "./quartz/cfg"
import * as Plugin from "./quartz/plugins"

/**
 * Quartz 4.0 Configuration
 *
 * See https://quartz.jzhao.xyz/configuration for more information.
 */
const config: QuartzConfig = {
  configuration: {
    pageTitle:            "The Yak Collective",
    pageTitleSuffix:      " :: The Yak Collective",
    enableSPA:            false,
    enablePopovers:       false,
    analytics:            null,
    locale:               "en-US",
    baseUrl:              "www.yakcollective.org",
    ignorePatterns:       [],
    defaultDateType:      "created",
    generateSocialImages: true,
    theme: {
      fontOrigin: "googleFonts",
      cdnCaching: true,
      typography: {
        header: "Playfair Display",
        body:   "Noto Serif",
        code:   "Noto Sans Mono"
      },
      colors: {
        lightMode: {
          light:         "hsla( 0,   0%, 100%, 100%)", // --bg1
          lightgray:     "hsla( 0,   0%,  90%, 100%)", // --ui1
          gray:          "hsla( 0,   0%,  84%, 100%)", // --ui2
          darkgray:      "hsla( 0,   0%,   6%, 100%)", // --tx1
          dark:          "hsla( 0,   0%,   4%, 100%)", // --tx1 :: calc(var(--base-l) - 92%)
          secondary:     "hsla(37,  71%,  47%, 100%)", // --ax1
          tertiary:      "hsla(37,  71%,  39%, 100%)", // --ax2
          highlight:     "hsla(37,  50%,  76%,  30%)", // --hl1
          textHighlight: "hsla(37, 100%,  50%,  50%)"  // --hl2 :: use --accent-h, not 60
        },
        darkMode: {
          light:         "hsla( 0,   0%,  15%, 100%)", // --bg1
          lightgray:     "hsla( 0,   0%,  21%, 100%)", // --ui1
          gray:          "hsla( 0,   0%,  27%, 100%)", // --ui2
          darkgray:      "hsla( 0,   0%,  82%, 100%)", // --tx1
          dark:          "hsla( 0,   0%,  86%, 100%)", // --tx1 :: calc(var(--base-l) + 71%)
          secondary:     "hsla(37,  71%,  56%, 100%)", // --ax1 :: calc(var(--accent-l) * 60 / 50)
          tertiary:      "hsla(37,  71%,  64%, 100%)", // --ax2
          highlight:     "hsla(37,  50%,  40%,  30%)", // --hl1
          textHighlight: "hsla(37, 100%,  66%,  30%)"  // --hl2 :: use --accent-h, not 33
        }
      }
    }
  },
  plugins: {
    transformers: [
      Plugin.FrontMatter(),
      Plugin.CreatedModifiedDate({
        priority: [
          "frontmatter"
        ]
      }),
      Plugin.SyntaxHighlighting({
        theme: {
          light: "material-theme-lighter",
          dark:  "material-theme-darker"
        },
        keepBackground: false
      }),
      Plugin.ObsidianFlavoredMarkdown({
        enableInHtmlEmbed: true
      }),
      Plugin.GitHubFlavoredMarkdown(),
      Plugin.HardLineBreaks(),
      Plugin.TableOfContents({
        maxDepth: 6
      }),
      Plugin.CrawlLinks({
        markdownLinkResolution: "shortest",
        prettyLinks:            false,
        openLinksInNewTab:      true,
        lazyLoad:               true
      }),
      Plugin.Description(),
      Plugin.Latex({
        renderEngine: "mathjax"
      })
    ],
    filters: [
      Plugin.RemoveDrafts()
    ],
    emitters: [
      Plugin.ComponentResources(),
      Plugin.ContentPage(),
      Plugin.ContentIndex({
        rssLimit:          1024,
        rssFullHtml:       true,
        includeEmptyFiles: false
      }),
      Plugin.Assets(),
      Plugin.Static(),
      Plugin.NotFoundPage()
    ]
  }
}

export default config
