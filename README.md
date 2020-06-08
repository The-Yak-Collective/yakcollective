# The Yak Collective

Home page of the Yak Collective projects.

[![Netlify Status](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)](https://app.netlify.com/sites/practical-lichterman-20c7e0/deploys)

## Updates

Updates can be made using Netlify CMS at https://yakcollective.org/admin. Changes can be submitted by anyone with a GitHub account, but must be approved by a member of the Yak Collective GitHub team with sufficient permissions to approve and merge pull requests.

## Development

Significant website changes should be made using short-lived [topic branches](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows) that are merged into `netlify-prod` when ready. The Yak Collective Netlify account can be used to create temporary websites when such changes need to be reviewed broadly.

## Make It Go

To build things locally...

```sh
bundle config set path vendor/bundle
bundle install
bundle exec jekyll build
```

When doing local development, you may want to run `bundle exec jekyll serve` instead to fire up Jekyll's local server mode so that you can connect to http://localhost:4000 and browse the current version of the site.

Netlify will rebuild the site automatically whenever changes are pushed to the repo and/or merged in.

## Documentation

Here's a quick rundown of the moving parts here.

### Pages

- `about.md`
- `index.md`
- `members.md`
- `projects.md`
- `writings/feed.json`

	[JSON feed](https://jsonfeed.org/) for member writings, structured after John Gruber's feed on [Daring Fireball](https://daringfireball.net/) (e.g., posts link back to the original article, and _not_ yakcollective.org).

- `writings/feed..xml`

	RSS feed, equivalent to `writings/feed.json`.

- `writings/index.html`

### Assets

- `assets/*`
- `robots.txt`

### Collections

- `members`

	Member data, one person per file. Referenced by projects and posts.

- `projects`

	Yak Collective projects.

- `sequences`

	Sequences used to group projects. Projects are counted in "days released since X".

### Member Feeds (a.k.a. "Writings")

Posts in `writings/_posts` are auto-pushed from member RSS feeds using [IFTTT](https://ifttt.com/) and [Netlify Functions](https://functions.netlify.com/).

Current feeds pulled are documented in [`FEEDS.md`](https://github.com/The-Yak-Collective/yakcollective/blob/warren-structure/FEEDS.md). To add or update a member feed, follow the directions in that file.

The Glitch bits of the feed infrastructure are:

- `packages.json`
- `functions/*`

### Templates

Pages in the `_layouts` folder:

- `default.html`

	Base layout. This isn't actually used on any pages, but is inherited by other layouts.

- `member.html`

	Used for member pages.

- `member-list.html`

	Used for the member list page (`members.md`).

- `minimal.html`

	The most minimal layout used on `yakcollective.org`. Directly used on the site home page (`index.md`), and inherited by most other layouts (with the exception of `project.html`).

- `page.html`

	Normal layout for stand-alone pages.

- `post.html`

	Layout for posts. Every post is assumed to have an author defined in the `members` collection.

- `project.html`

	Fancier formatting for pages in the `projects` collection.

- `project-list.html`

	Used for the project list page (`projects.md`).

### Shared Elements

Reusable elements from the `_includes` folder:

- `analytics.html`

	Google Analytics code; included on all pages by proxy through `_layouts/default.html`.

- `footer.html`

	Page footer elements.

- `head.html`

	HTML `<head/>` elements (things like `<meta/>` tags, _not_ page headers).

- `page.css`

	CSS used for per-page customization (accent colors, hero images, etc.).

- `member-card-html`

	Reusable "member card" element, currently used in the members list, individual member pages, and in the `_layouts/post.html` template.

- `nav.html`

	Page navigation elements.

- `project-box.html`

	Project card, used in the projects list and individual member pages.

- `toc.html`

	Table of contents for `_layouts/page.html` elements. Does unreal things with Liquid. Probably black magic.

### Build Infrastructure

- `admin/*`

	[Netlify CMS](https://www.netlifycms.org/).

- `_config.yml`
- `Gemfile`
- `Gemfile.lock`
- `netlify.toml`

	Various Netlify build directives, just redirects right now.
