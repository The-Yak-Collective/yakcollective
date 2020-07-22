---
title: About the Yak Collective
---
## Overview

The "admin" interface (provided by Netlify) is used to edit the content which is shown on the Yak-Collective.org (YC.org) website. Currently, the way to get here is to tack "/admin" at the end of the url of YC.org. You also needed to login using your github account.

There are two types of users:

1. Regular users can propose changes, which will then be reviewed and rejected or accepted.
2. Administrative users are capable of reviewing and accepting their own changes and therefore should be more careful.

The menu bar includes three icons on the left, used for selecting tabs:

1. Contents
2. Workflow
3. Media

You are now in the *Contents* tab. The *Media* tab is used for managing media (images in YC.org). The *Workflow* tab is used for the reviewing process. 

The "Quick add" pulldown menu can be used to quickly jump to the interface for adding members, projects and sequences.

### The contents tab

The YC.org website is built by taking items out of collections and creating websites from them (currently using Netlify for the content management and Jekyll for the arrangement. This may change and the format of the content will probably change as well at that time).

The content is arranged in collections. On the left there is a list of collections of data items.
Most of the data is provided as markdown files (.md), with yamal-style front matter (between the "---" and "---" at the start of the file).

The first one is not part of the website and merely contains this helpfile. Please do not edit it by mistake while reading the help. Following are:

* *members*, used for adding and editing member data.
* *projects*, used for adding and editing project data.
* *sequences*, used for adding and editing sequence data.
* *slogans & tips*, used for adding and editing slogans (what you see on bottom of page) and tips data (what you see if you find the tips).
* *pages*, used for editing the static text on pages.
* *netlify.toml*, for managing some configuration information of the Netlify system. you probably should ignore this.

## Typical Activities

### Edit a regular page

* Select the *Pages* collection
* Select a page to edit, from the collection list
* Edit in markdown or rich text on the left side, with a preview on the right side of the screen. Please avoid messing up the HTML, Javascript and Jekyll directives that are inline.
* Click save on top menu
* Note the "View Live" option on the top menu, on the right, which takes you to the website. If you are not able to *Publish* it will not reflect any changes you make. If you do publish, it takes a few minutes to propagate.
* Go back to the collection list using the left arrow in upper right side of screen (hopefully marked "CHANGES SAVED").

### Edit an existing member

* Select the *Members* collection
* Select a member to edit, from the collection list. Note the availability of sort and of grid view.
* You will see a list of fields to fill in. Please follow the hints. On the right you have a preview, which is imperfect.
* Click save on top menu
* Note the "View Live" option on the top menu, on the right, which takes you to the website. If you are not able to *Publish* it will not reflect any changes you make. If you do publish, it takes a few minutes to propagate.
* Go back to collection list using the left arrow in upper right side of screen (hopefully marked "CHANGES SAVED").

### Add a tip

* Select the *Slogans & Tips* collection
* Select  *Tips* from the  list
* The slogans and tips are stored in yaml files, what you see is a list of items, each corresponding to one entry in the file. Each item has sub-items according to the item definition; for tips, "TIP" and "AUTHOR".
* Click on the "Add tips +" button in upper right corner of list
* Ented information using plain text.
* Click save on top menu
* Note the "View Live" option on the top menu, on the right, which takes you to the website. If you are not able to *Publish* it will not reflect any changes you make. If you do publish, it takes a few minutes to propagate.
* Go back using the left arrow in upper right side of screen (hopefully marked "CHANGES SAVED").

## How workflow works

When you edit or create a new entry (and press "save") it is saved as a draft and you can set its status to *review*, if you are ready to publish. However, in order to publish it needs to actually be published.

If you are an administrator, you can set the status to *ready*, and then hit *Publish*. After 1-3 minutes, it is part of the YC.org website.

If you are not an administrator, you cannot. (What actually happens is that a new branch is created in Github just for your change and a pull request created, which is resolved when the entry is published by an administrator)

In the Workflow tab, there are three (only first two if you are not an administrator). Each entry to be published is shown as a card either in the *Drafts* column, the *In Review* column or in the *Ready* column. The cards can be moved around by dragging as you see fit. Once in the *Ready* column, and you hover over a card, a *Publish new entry* button appears and is active, and if clicked, will publish the entry (and rebuild the Website in the process).

The *Delete* button deletes entries.

## Some things to be aware of

* When you make a change that is accepted, it can take 1-3 minutes before the updated website is built. So, do not expect instant changes in the website, and do not multi-click in a futile effort to make things faster. In some (rare) cases, what you change will cause a failure to build and then the website will not be updated. Such failure is not reflected in the "admin" interface.
* Please do not amend the .toml file
* while the pages are in Markdown format, they also include Jekyll directives {% raw %} (e.g., curly braces of various types ) {% endraw %} and HTML and Javascript. Please be careful not to modify these unintentionally.
* I did not describe some additional minor functionality.

## Things that don't work

* When creating a new member/project, the created card may indicate "invalid date" this does not seem to affect functionality.
* Preview of *Projects* is bad, as *css* is not applied.
* Preview of *members* is ok, but does not reflect what you see on webpage. that is what "view live" is for.
* No preview of sequences.

*TBD*
but pls tell us of any issues, perhaps by a message on the #infrastructure channel.

\--

<details class="f6">
	<summary>Website colophon</summary>
	<p>Site version {{ site.version }}.</p>
	<p>Built by <a href="https://tomcritchlow.com">Tom Critchlow</a> &amp; Nathan Acks using <a href="https://jekyllrb.com/">Jekyll</a>, <a href="https://github.com/">GitHub</a>, <a href="https://ifttt.com/">IFTTT</a>, and <a href="https://www.netlify.com/">Netlify</a>.</p>
</details>