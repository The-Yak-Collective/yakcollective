---
title: Member Template
date: 2020-12-09 00:00:00
---
This is a template for a member data file. While formally this is just a special kind of page, internally we treat these `.md` files more like a data structure that is then referenced in many other pages. Because of this, the most important part of these files is the front matter -- you'll notice that most pages don't even have any content beyond that.

That doesn't mean that you _can't_ add page content -- if you do, it will be treated a bit like a "long bio" and displayed on your member page. But even here, the `bio_short` front matter attribute (see below) will be used in more places. If you do add a "long bio" as page content, stick to plain Markdown conforming to the [kramdown](https://kramdown.gettalong.org/) spec.

File names (less the `.md` extension) become the member ID, which is then used in various places across the Yak Collective website. File names (and hence member IDs) should follow a "last name + dash + first name" format, so a member named "Nathan Acks" should get a member file called `acks-nathan.md`. By convention, member avatars are named in the same fashion (`acks-nathan.jpg`, etc.), but this is simply to make file management easier.

Note that the functionality represented by the member data files will eventually be subsumed into [Knack](https://yak.knack.com/yaks#yak-profile/).

## Required Front Matter

The front matter (the bit between the two `---` lines at the top of the file) listed at the top of this file represents the _minimal_ frontmatter for a project main page.

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

_Required_ front matter attributes are described in the following sections.

### `title`

This is the member's _name_ ("Venkatesh Rao", Maier Fenster", etc.). Just go with it.

### `date`

This is the member's "made yak" date in ISO "YYYY-MM-DD". _Generally_ it will match the publication date of the first project that they are listed in the credits for.

Because of limitations with how Jekyll handles date conversions, it's necessary to specify this as a full timestamp, though by convention the time part is always "00:00:00" (no timezone). Thus December 9, 2020 would be written as `2020-12-09 00:00:00`.

Members without a `date`, or whose `date` is in the future, will not be displayed on the website.

## Optional Front Matter

The following _optional_ frontmatter attributes are supported for generic pages.

```yaml
indie_status: 10 years
tagline: Just a template, showing people how it's done
previously: A todo item in Roam
currently: A file in GitHub
avatar: /members/template-member.jpg
twitter: yak_collective
links:
  - title: Website
    url: https://www.yakcollective.org/
  - title: Newsletter
    url: https://yakcollective.substack.com/
bio_short: |
  I'm a template file that exists to demonstrate how to construct a member data file.
page_text_color: black
page_bg_color: 255,255,255
page_headers: |
  <!-- HTML -->
```

Each of these header attributes is described in more detail in the following sections.

<!--
indie_status: 10 years
tagline: Just a template, showing people how it's done
previously: A todo item in Roam
currently: A file in GitHub
avatar: /members/template-member.jpg
twitter: yak_collective
links:
  - title: Website
    url: https://www.yakcollective.org/
  - title: Newsletter
    url: https://yakcollective.substack.com/
bio_short: |
  I'm a template file that exists to demonstrate how to construct a member data file.
-->

### `page_text_color`

One of `black` (for black text on a default white background) or `white` (for white text on a default black background). If unset, defaults to `black`.

### `page_bg_color`

Use this to override the default page background color, as specified by `page_text_color` (above). This color _must_ be specified as an RGB tuple; for example, `255,255,0` is a bright yellow, and `128,128,128` is a medium gray.

### `page_headers`

An attribute for advanced users; anything included here will be inserted verbatim at the end of the page's HTML `<head/>`. Use this to specify additional CSS or JavaScript. Because this attribute expects raw HTML, you definitely want to use the "`|` + indent" syntax.

Note that the Yak Collective website is based on the [Tachyons design framework](https://tachyons.io/docs/), so you can use any of the classes that Tachyons defines _without_ specifying `page_headers`.

Be aware that it's very easy to break you page if you don't know what you're doing with this attribute. If anything in the above two paragraphs doesn't make sense to you, you should probably _not_ use this attribute!

## Widgets

You should _not_ use any widgets on member data pages, as these are intended to be informational, rather than expressive.
