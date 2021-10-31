---
---
# Generic Page Template

This is the template file for a generic page. Pages like this can live anywhere on the website, but in general you'll want to place them in the website "root" (the top level directory, where `about.md`, `members.md`, `projects.md`, etc. reside).

If you want your page to show up in the top-level menu, you'll also need to edit the `_layouts/default.html` file. However, if you're just creating a landing page or a page that's linked from somewhere else, then simply creating a new file in the right format will be enough.

Pages will be linked using the filename, less its extension. So this page (if it weren't disabled) would live at <https://www.yakcollective.org/template-page/>, since this file is called `template-page.md`.

Generic pages are plain Markdown files; in Jekyll, these files should conform to the [kramdown](https://kramdown.gettalong.org/) spec.

## Required Front Matter

No front matter (the bit between the two `---` lines at the top of the file, which _must_ be included, even if there's nothing between them) is required for generic pages _if_ the first line of the actual page contents is a top-level header (`# Generic Page Template` in the present case). If you _don't_ want to start your page with a header line for whatever reason, _or_ if you want your page title (as displayed by the browser) to be different than this initial header line, then you should include a `title` attribute. For example,

```markdown
---
title: "Something Something"
---
# Something Else

Page content, and so on.
```

will generate a page whose top-level header is _Something Else_, but whose browser tab uses the title _Something Something_.

Be aware that if the _value_ of your front matter attribute contains a `:`, `&`, or `#`, then you _must_ either surround it in double quotes (`"`) _or_ use a `|` character, followed by a line break, and then with subsequent lines (until the next front matter attribute or the closing `---`) indented by _two_ spaces. So something like this

```yaml
title: "My #1 Page Title: Now With Two Unsafe Characters!"
```

is equivalent to

```yaml
title: |
  My #1 Page Title: Now With Two Unsafe Characters!
```

In general, you should use quotes for shorter, single line values. Use the "`|` + indent" syntax for longer values, or when you need to use multiple lines.

For more information about the ins-and-outs of page front matter, refer to [Jekyll's documentation](https://jekyllrb.com/docs/front-matter/) and the [YAML specification](https://yaml.org/spec/1.2/spec.html).

_Optional_ front matter attributes are listed in the next section.

## Optional Front Matter

The following _optional_ front matter attributes are supported for generic pages.

```yaml
title: "An Alternate Page Title"
description: |
  An explicit page description for Twitter, Facebook, _et al._
author: 100041
page_text_color: black
page_bg_color: 255,255,255
page_headers: |
  <!-- HTML goes here  -->
```

Each of these header attributes is described in more detail in the following sections.

### `title`

Use this to set a page title that's _different_ than your initial header line (`# My Page Title`). If you do not include an initial header, then this attribute is _required_. See the previous section on _Required Front Matter_.

### `description`

A short one-or-two sentence description that will be displayed on Twitter cards, Facebook shares, etc. If you don't include this attribute, then the first 20 words of the page content will be used instead. While you _can_ include Markdown or HTML formatting here, it will be stripped during the build process, so best to just use plain text.

### `author`

The page author. Ideally, this should be the filename (less the extension) of someone in the `members` directory: So, to specify Venkatesh Rao as a page author, you'd set this to `100041` (since the corresponding member file is `members/100041.md`). When use in this form, information about the specified Yak Collective member will be pulled into Twitter (and other services that support Twitter cards) when the page URL is shared.

Alternately, you can just specify someone's name ("Venkatesh Rao"). This is still useful to do to attribute the page (`author` information gets used in a lot of places), but won't pull in _any_ additional information (so the page will be attributed simple to the Yak Collective on Twitter, _et al._).

### `page_text_color`

One of `black` (for black text on a default white background) or `white` (for white text on a default black background). If unset, defaults to `black`.

### `page_bg_color`

Use this to override the default page background color, as specified by `page_text_color` (above). This color _must_ be specified as an RGB tuple; for example, `255,255,0` is a bright yellow, and `128,128,128` is a medium gray.

### `page_headers`

An attribute for advanced users; anything included here will be inserted verbatim at the end of the page's HTML `<head/>`. Use this to specify additional CSS or JavaScript. Because this attribute expects raw HTML, you definitely want to use the "`|` + indent" syntax.

Note that the Yak Collective website is based on the [Tachyons design framework](https://tachyons.io/docs/), so you can use any of the classes that Tachyons defines _without_ specifying `page_headers`.

Be aware that it's very easy to break you page if you don't know what you're doing with this attribute. If anything in the above two paragraphs doesn't make sense to you, you should probably _not_ use this attribute!

## Widgets

A variety of widgets can be included as part of your page.

### `widget-google-slides`

Insert a Google Slide deck in a centered "breakout box". _Requires_ a single parameter:

- **`gid`** is the Google Drive document ID for the Google Slides you want to embed. The `gid` is the long random string immediately prior to `/edit` in the URL for your document (not including the leading or trailing `/`).

Example usage:

```markdown
{% include widget-google-slides.html
   gid="1OfBuSq4SImE1Gq2EaAGCAlkwC8LZRCWx-7O_VOHJ5TI"
%}
```

See [_Don't Waste the Reboot_](/projects/dont-waste-the-reboot/) and [_The New Old Home_](/projects/the-new-old-home/) for examples of this widget in action.

### `widget-image`

Insert an image in a "breakout box". This is provided as a fancier, more versatile alternative to just writing `![My alt text.](/path/to/image.jpg)` in Markdown; however, be aware that images included in this fashion will _not_ show up in site RSS feeds!

This widget _requires_ the following parameter:

- **`image`** is the path to the image to include (relative to the final site).

There are also two optional parameters:

- **`layout`** can be one of `left` (pop content out on the left), `right` (pop content out on the right), `center` (center content, but pop out slightly from the main text on _both_ the left and right), or `full-bleed` (span from the left side of the browser window all the way to the right). If omitted, `center` will be used.

- **`alt`** specifies the image alt text. Including a descriptive alt text is recommended for accessibility reasons. Do not use Markdown!

- **`caption`** specifies a caption, and is often used to provide image credits. Markdown is permitted here.

Example usage:

```markdown
{% include widget-image.html
   layout="left"
   image="/projects/astonishing-stories/wholeness-in-a-timeless-activity.jpg"
   alt="Wholeness in a Timeless Activity"
   caption="Illustration by [Justice](/members/100048/)."
%}
```

See _Astonishing Stories_ project (sub)pages (such as ["Wholeness in a Timeless Activity"](/projects/astonishing-stories/wholeness-in-a-timeless-activity/)) for examples of this widget in action.

### `widget-member-card`

Member cards can be used either as links to the actual member page or as containers of member information. In general you should In the first case.

_Requires_ a single parameter:

- **`member`** is the ID of a member -- basically, the name of the corresponding file in `/members/`, less the `/.md` extension. For example, Venkatesh Rao's member card would be called by passing in `member="100041"`.

There is also an optional paramter:

- **`standalone`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter indicating whether the card should be presented as a fully-functional container of member information (true), or as a link to a member page (false). Treated as falsy if omitted, which is almost always what you want.

Example usage:

```markdown
{% include widget-member-card.html
   member="100041"
%}
```

Member cards can be found on many pages throughout the Yak Collective website; for example, start with the [_Members_](/members/) page itself to see cards in their "default" mode, and then click through to any member page to see a card in `standalone` mode.

### `widget-project-box`

Project boxes display project summary information, similar to member cards. As with member cards, they can be presented either as links to project pages or plain information containers, but unlike member cards you can't specify which to use -- project boxes are links if the project has been published, and simple containers if the project is unpublished.

There is a single _required_ parameter:

- **`project`** specifies a project ID -- the name of the file corresponding to the project in the `/projects/` directory, less the `.md` bit. So Future Frontier's project ID is specified by setting `project="future-frontiers"`.

The is also an optional parameter:

- **`hide_published`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter; when truthy, it _hides_ the final "published" timestamp line. Treated as falsy if omitted, which is almost always what you want.

Example usage:

```markdown
{% include widget-project-box.html
   project="future-frontiers"
%}
```

Project boxes can be found on many pages throughout the Yak Collective website. For example, the [_Projects_](/projects/) displays a list of project boxes in their "default" mode, while the [_Now_](/now/) page displays project boxes in the (unpublished) "container" mode with the timestamp line hidden.

### `widget-toc`

A widget that generates a "table of contents" from document headings. It has no configuration, and can _only_ be included on Markdown-formatted pages. If you are including this widget, it must come either immediately after the opening header line (`# My Page Title`) _or_ be the _first_ thing on the page if no leading header is being used.

Example usage:

```markdown
{% include widget-toc.md %}
```

See the [_About_](/about/) page for an example of this `widget-toc` in action.

### `widget-post-list`

A widget that generates a list of _posts_, organized by month and year. It can _only_ be included on Markdown-formatted pages.

Be aware that [_posts_](https://jekyllrb.com/docs/posts/) are **_not_** the same thing as [_pages_](https://jekyllrb.com/docs/pages/). Currently, only cached newsletter pages and member writings are accessible using this widget.

This widget has no required parameters _per se_, but if you're using it you'll almost certainly want to set at least some of the following:

- **`init_header_level`** specifies the initial header level to use. If "2" is passed in, then `h2` tags will be used for years and `h3` tags for months, etc. Defaults to "2", as that's what most pages will use. Values larger than "5" are treated as "5", since `<h7/>` tags don't exist in HTML.

- **`show_author`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter that specifies whether to show post author (if it is set).

- **`author`** allows you to filter posts by a given member ID (`100041`, etc.).

- **`category`** allows you to filter posts by category. Currently only `newsletters` and `writings` are valid post categories.

Example usage:

```markdown
{% include widget-post-list.md
   init_header_level=2
   show_author=true
   category="writings"
%}
```

The canonical post list is the [_Writings_](/writings/) page, but it is also included on some individual member pages.

### `widget-project-header`

The widget that's used to display a project header. It's really meant to be included as the first line of content for a project, but if you want you can include it anywhere by specifying the optional `project` parameter (which should be a valid project ID). This parameter is not necessary on the project's main page.

Example usage:

```markdown
{% include widget-project-header.html
   project="dont-waste-the-reboot"
%}
```

See [_Don't Waste the Reboot_](/projects/dont-waste-the-reboot/), [_The New Old Home_](/projects/the-new-old-home/), [_Astonishing Stories_](/projects/astonishing-stories/), and [_Future Frontiers_](/projects/future-frontiers/) for examples of this widget in action.

### `widget-project-page-list`

Include a grid of project page boxes for all _displayed_ pages associated with a given project. A "displayed" project page is one for which the `hidden` front matter attribute is either false or unset; see `projects/template-project/template-page.md` for more details.

Projects will be listed (in ascending order) by date, and then by URL (essentially file name).

This widget is designed to be included on a project's main page, and requires no parameters in this case. In all other cases, the `project` parameter should be included and set to a valid project ID.

Example usage:

```markdown
{% include widget-project-page-list.html
   project="astonishing-stories"
%}
```

See [_Astonishing Stories_](/projects/astonishing-stories/) for an example of this widget in action.

### `widget-project-slide-deck`

Create [an _Idle Words_ style "infinity" slide deck](https://idlewords.com/talks/). This is accomplished by chaining together instances of `widget-slide`, with slide data drawn from project slide files (see `projects/template-project/project-slide.md`).

Slides will be listed (in ascending order) by URL (essentially file name).

You can technically call this without any parameters from a project's main page, but you'll probably be much happier if you set at least _some_ of the many optional parameters:

- **`project`** specifies a valid project ID ("future-frontiers"). It is only necessary if `widget-project-slide-deck` is included in a page other than a project's main page.

- **`hero_position`** specifies whether slide hero images should be on the `left` or `right` for _all_ slides. If unset, each slide will use the value specified by the slide file itself (which may or may not be consistent).

- **`slide_separator`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter that specifies whether or not to add a (top) border between slides.

- **`slide_align`** specifies whether slide `hero_image` and `slide_content` should be aligned to the `top`, `bottom`, or `center` for _all_ slides. If unset, each slide will use the value specified by the slide file itself (which may or may not be consistent).

- **`title_links`** controls how slide titles should be linked. One of `internal` (links to the anchor of the current slide), `external` (links to the stand-alone slide page), or `none` (no link). If unset, `external` is used.

- **`show_dates`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter that specifies whether or not slide dates should be displayed.

- **`collapse_slides`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter that specifies whether or not slide titles and authors should be suppressed if identical between sequential slides.

- **`table_of_contents`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter that specifies whether a table of contents for the deck should be generated.

- **`table_of_contents_hero`** specifies the image to use for the table of contents slide. If unset, the project's `hero_image` attribute is used.

- **`table_of_contents_hero_description`** specifies the image alt text for the table of contents slide. If unset, the project's `title` attribute is used.

- **`table_of_contents_hero_caption`** specifies the image caption for the table of contents slide (generally used for image credits).

Example usage:

```markdown
{% include widget-project-slide-deck.html
   project="future-frontiers"
   hero_position="left"
   slide_separator=true
   slide_align="top"
   title_links="internal"
   show_dates=true
   collapse_slides=true
   table_of_contents=true
   table_of_contents_hero="/projects/future-frontiers/table-of-contents.jpg"
   table_of_contents_hero_description="Table of contents"
   table_of_contents_hero_caption="[Venkatesh Rao](/members/100041)"
%}
```

See [_Future Frontiers_](/projects/future-frontiers/) for an example of this widget in action.

### `widget-slide`

An advanced, lower-level widget used for producing slide-like layouts. The main reason this is considered to be "advanced" is that you will generally want to pass in either multi-line Markdown or straight HTML for the `slide_content`, which necessitates the use of [Liquid's `capture` operator](https://shopify.github.io/liquid/tags/variable/#capture). It _requires_ only a single parameter:

- **`slide_content`** is the, well, slide content. It can be either Markdown or HTML (or a mix). Keep in mind that this is a slide, so you should probably stick to something short -- a paragraph (maybe two), a bulleted list, etc.

There are a bevy of optional parameters:

- **`hero_image`** is the "hero" image for the slide, which will take up half of the space either to the left or right of the `slide_content`. If unset, a full-width slide is produced (images can still be embedded within that slide using Markdown or HTML, however).

- **`hero_position`** specified whether `hero_image` will be on the `left` or `right` of the `slide_content`. If unset, `left` is used.

- **`hero_description`** is the alt text for the `hero_image`.

- **`hero_caption`** specifies a caption to display below the `hero_image`. Most commonly used for image credits.

- **`hero_border`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter indicating whether or not to display a thin border around the `hero_image`. If unset, no border is drawn.

- **`slide_separator`** is a [truthy/falsy](https://shopify.github.io/liquid/basics/truthy-and-falsy/) parameter indicating whether or not to add a border along the top of the slide. This is useful to set when displaying multiple slides sequentially.

- **`slide_align`** specifies whether the `hero_image` and `slide_content` should be `top`, `bottom`, or `center` aligned. If unset, `top` will be used (which is probably what you want).

- **`slide_id`** specifies an HTML element ID to be attached to the slide's containing `<div/>`. This is useful if you want to link to a slide or use the `page_headers` front matter attribute to specify per-slide CSS styling.

Most of the time you'll want to create project slides (see `projects/template-project/template-slide.md`) and then use `widget-project-slide-deck` to display them, rather than calling this widget directly. Check out [_Future Frontiers_](/projects/future-frontiers/) to get a sense of what `widget-slide` (along with a little CSS) can do.

### `widget-breakout-box`

An advanced, low-level widget that breaks a specified bit of content out of the main text flow. Can be used for pull quotes and the like (Markdown), but can also be passed entire blocks of HTML. It _requires_ a single parameter:

- **`content`** defines the content (HTML or Markdown) to be removed from the main text flow.

There are also two optional parameters:

- **`layout`** can be one of `left` (pop content out on the left), `right` (pop content out on the right), `center` (center content, but pop out slightly from the main text on _both_ the left and right), or `full-bleed` (span from the left side of the browser window all the way to the right; you probably only want to use this when passing HTML). If omitted, `center` will be used.

- **`extra_class`** specifies additional class(es) that will be added to the outer `<div/>` of the breakout box. Useful for controlling positioning for fancy formatting (either Tachyons classes or styling specified directly using the `page_headers` front matter attribute).

Note that `widget-google-slides`, `widget-image`, `widget-post-list`, `widget-project-header`, `widget-project-page-list`, and `widget-slide` are all based off of `widget-breakout-box`.

### `widget-iframe`

An _experimental_ widget that allows you to embed an external page in the Yak Collective website. It _requires_ a single parameter:

- **`url`** is the URL of the external webpage you want to embed.

The viewport for the embedded page will extend from just below the standard Yak Collective header to just above the standard footer, and from the far left to far right of your browser window. Because of this, if you use `widget-iframe`, it must be the **_only_** content on your page (which implies that you _must_ use the `title` attribute in the front matter for pages including this widget).
