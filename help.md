---
title: Admin Interface Help
---

## Overview

The "admin interface" is [a simple, open source interface maintained by Netlify](https://netlifycms.org/) that can be used to edit the content of the Yak Callective website. It can be accessed at <https://www.yakcollective.org/admin>, and requires a [GitHub](https://github.com/) account to login. _Anyone_ can propose changes to the Yak Collective website using this interface, but all changes must be approved by a member of the Yak Collective GitHub team.

## Interface Overview

There are three views, accessible through the options on the left-hand side of the menu bar:

1. Contents
2. Workflow
3. Media

You are currently in the **Contents** view, which is used for editing site pages and data. The **Workflow** view is used for the content review process reviewing process. The **Media** view is used for managing media (images, PDF files, etc.).

The **Quick add** dropdown on the right-hand side of the menu bar can be used to quickly jump to the interface for adding members, projects and sequences.

## Contents View

The Yak Collective website is built around groups of data files called "collections". These files are often (but not always) pages themselves, but also can be pulled in elsewhere on the website. For example, data files in the **Members** collection define the member pages, but also supply the internal data used to construct the member "cards" that link to these pages, and also provide the "glue" that allows the website to "know" that the Venkatesh Rao listed on a given project page is the same person as listed on the "writings" page. These data files are simply [Markdown](https://en.wikipedia.org/wiki/Markdown) (`.md`) files using [YAML](https://yaml.org/) "[frontmatter](https://jekyllrb.com/docs/front-matter/)".

The first collection is not part of the website, but rather contains this help file. The remaining collections are:

- **Members**, which define individual contributors to Yak Collective projects;
- **Projects**, which define the Yak Collective's projects themselves;
- **Sequences**, which group projects into chronological, thematically-related sequences;
- **Slogans & Tips**, which hold the slogans displayed at the bottom of each page and the associated "tips" easter egg; and
- **Pages**, which define a handful of static pages on the website (the homepage, about page, and member and project index pages).

## Typical Activities

### Edit a Page

- Select the **Pages** collection.
- Select a page to edit from the collection list.
- Edit in Markdown or "rich text" on the left side; a preview will be displayed on the right side of the screen. Be aware that some HTML, JavaScript, and Jekyll directives (`{% stuff %}`) may not fully render.
- Click save on top menu. If your change has been saved successfully, you should see **CHANGES SAVED** just to the left of this button.
- You can return to the collection list using the left arrow in top left of screen.

### Edit an Existing Member

- Select the **Members** collection.
- Select a member to edit from the collection list. Because the **Members** collection is so large, it can be useful to switch to the grid view or change the sorting using the controls in the top right of the collection list.
- You will see a list of fields to fill in. Any fields not marked as **OPTIONAL** are required. Most fields will have some hints that will help you fill them in. Note the the preview to the right will not reflect the final presentation of the member page.
- Click save on top menu. If your change has been saved successfully, you should see **CHANGES SAVED** just to the left of this button.
- Click save on top menu. If your change has been saved successfully, you should see **CHANGES SAVED** just to the left of this button.
- You can return to the collection list using the left arrow in top left of screen.

### Add a Tip or Slogan

- Select the **Slogans & Tips** collection.
- Depending on what you want to add, select either **Slogans** or **Tips** from the list. Note that both of these files can sometimes take a few moments to load.
- You will see a list of items, each corresponding to one entry in the file you just selected.
- Click on the **Add tips +** or **Add slogans +** button in upper right corner of list to add a new tip or slogan. Note that all fields are required, and HTML and Markdown will _not_ be rendered (plain text only).
- Click save on top menu. If your change has been saved successfully, you should see **CHANGES SAVED** just to the left of this button.
- You can return to the collection list using the left arrow in top left of screen.

## Content Workflow

When you edit or create a new entry (and press the **Save** button) it is saved as a _draft_. Once you're happy with your edits, you should change the associated status to _review_; this will create what's called a "pull request" that the Yak Collective GitHub team can then apply to the actual website.

Members of the Yak Collective GitHub team have an additional option: They can change the status of their edits directly to _ready_. Any edits marked as _ready_ will go live on the website 1 - 3 minutes after the **Publish** button is clicked.

The **Workflow** view contains a simple [Kanban board](https://en.wikipedia.org/wiki/Kanban_board) representing the status of your content. Entries in the _draft_ state will be in the **Drafts** column, while those in the _review_ state will be in the **In Review** column. Yak Collective GitHub team members can see a third, **Ready** column for content that will go-live during the next site build (triggered by the **Publish** button). Hour can easily change the state of any content you have added or edited by dragging the corresponding card between the columns. Once content is in the **Ready** column, hovering over it will reveal a **Publish new entry** button that will immediately push that content (but not any other content) to the site. Rmember that it will take 1 - 3 minutes for new content to appear on the website after **Publish new entry** is clicked,.

The **Delete** button deletes the proposed change.

## Notes

- When you make a change that is accepted, it can take 1 - 3 minutes before the updated website is built. In some (rare) cases, your change may cause a failure, in which case the website will not be updated. Failures are not reflected in the admin interface.
- The **View Live** link in the upper right on the menu bar is currently non-functional, and will only take you to the _current_ version of the website.
- Some pages include Jekyll directives (`{% stuff %}`). Please be careful not to modify these unintentionally.
- When creating new members and projects, the created card may indicate "invalid date" in the **Workflow** view. This does not seem to affect functionality.
- Member and project previews are _very_ not reflective of the final web page.

The admin interface is very much a work-in-progress, and will likely change significantly over the coming months. _Your_ input will help us improve it in the ways most useful to other yaks; please don't hesitate to drop your suuggestions in the `#infrastructure` channel on Discord or create a [GitHub issue](https://github.com/The-Yak-Collective/yakcollective/issues).
