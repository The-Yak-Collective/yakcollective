---
title: "\U0001F6E0️ quicksidian"
date: 2022-07-28 00:00:00.000000000 Z
layout: post-external
original_link: https://person-al.github.io/%F0%9F%9B%A0%EF%B8%8F/2022/07/28/quicksidian.html
author: 100646
---

## Background

The Obsidian mobile app can be slow to load.[1](#fn:1) When you need the power of Obsidian, this isn’t an issue. But when it comes to quick-capture, this can be a dealbreaker. Quicksidian should be the perfect companion for those quick “I just need to write this sentence down” and those “I should share this to my vault for later” moments.

## What feedback do I need?

If you’re reading this, you’re likely intrigued by the idea. Here’s how to give helpful feedback on Quicksidian:

1. If this isn’t something you’d use, that’s okay! I’m building this for myself foremost and don’t care if the eventual audience is just 1. However, if you have solutions that solve the “slow Obsidian” problem for you, do let me know! Maybe I don’t need to build a whole app after all. 
  - I’ve gotten a few great suggestions here: FleetingNotes requires an account, but has an Obsidian vault-syncing plugin, apparently. And Markor, the popular Markdown app for Android, has a “Quicknote” feature and sharing functionality. Neither support templates, but that’s likely a nice-to-have anyway.
2. If you would use this, let me know! The encouragement will help make it happen.
3. If you see a ?, it means I’m not sure which user experience is best. Please let me know what you think.
4. Features marked as (Optional) are likely complex to build and I’m not sure if they’re worth it. If you see an easy solution, let me know. And if you think they’re worth it, let me know.

If you’d like to follow along, you can subscribe to [the blog’s RSS feed](/feed.xml) or [this project-specific feed](/feed/by_tag/quicksidian.xml).

## Goals

In building Quicksidian I aim to:

- solve the specific use-case of quick-capture
- build an Android app
- allow sharing text and URLs via the Android share panel
- support basic templates (maybe templater templates?)
- allow sharing directly to a specific file in your vault (perhaps allow bookmarking some files?)
- allow quickly creating a brand new file in your vault
- allow basic file modification

## Non-Goals

The following will NOT be part of this project:

- Recreating Obsidian functionality 
  - Even things like the double-bracket file-search are beyond the scope of this project, imo. Anything Obsidian does well, we should leave to Obsidian. This is more for 30 second interactions.
- Support non-Android platform
- Support complex templates
- Support any Obsidian community plugins
- Render markdown in a pretty way
- Nice-to-have file editing tools like undo/redo

## User Flows

### New note capture

1. User has a sudden thought
2. They opens Quicksidian and is directly in their vault
3. They quickly create a new file that can follow a basic template
4. They write what’s needed in the new file
5. User closes Quicksidian, the file is saved automatically
6. Later, user can find that same file in their vault

### Share capture

1. User is browsing social media or reading an article on their phone browser.
2. They come across a sentence or tweet that they’d like to save for later.
3. User clicks Android’s built in “share” button for their selection.
4. They select “Quicksidian” in the share menu.
5. Quicksidian gives the user the option to share the content to a brand new file, append it to a bookmarked file, or select a file to append it to. 
  1. Brand new file: the user is prompted for the file title. The file is created and the content pasted.
  2. Append to bookmarked file: the content is pasted to the end of the selected file.
  3. Select a file: the file selector opens. Once the user has selected a file, the content is pasted to the end of that file.
6. Do we want Quicksidian opens in another window with the content?

### Supported Settings

- The user selects the folder in their phone that serves as their vault
- The user bookmarks files to append to
- (Optional) The user selects the folder in their phone that contains templates
- (Optional) The user selects what template to use for newly created files
- (Optional) The user selects a template for pasting content. (e.g. `${timestamp} ${shared_content}` - Should it be Templater or Obsidian template syntax? Or is that too complicated?).

## Architecture

This part is in progress. In the meantime, I want to get feedback from the Obsidian community on the idea above.

If you’d like to follow along, you can subscribe to [the blog’s RSS feed](/feed.xml) or [this project-specific feed](/feed/by_tag/quicksidian.xml).

**Info** :

- **Inspired by:** opening the app to write [[🛠️ vocab finder]] (and other instances of the same thing)
- **Related to:**
  - [[🌰 Zettelkasten]]
  - [[🧪 Obsidian Experiment Guide]]

1. It’s a heavy app that does a lot! It makes sense that it would make take time to load. But also, I love this gif and couldn’t resist adding it. ![glacial_pace_meryl_streep.gif](/assets/f1027e282c80402beaad058a802e74fef7e1e9e8bcb4f19143a02012c5edbbe6.gif) [↩](#fnref:1)

