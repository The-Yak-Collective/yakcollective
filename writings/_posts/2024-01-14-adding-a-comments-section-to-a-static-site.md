---
title: "\U0001F331 adding a comments section to a static site"
date: 2024-01-14 00:00:00.000000000 Z
layout: post-external
original_link: https://person-al.github.io/%F0%9F%8C%B1/2024/01/14/adding-a-comments-section-to-a-static-site.html
author: 100646
---

> **Assumed Audience:** You have a blog, most likely a static site hosted on Github Pages or another static site hosting system. You want to enable a comments section, or at least a way for readers to contact you, but you don’t know how.

The biggest risk in making a personal site is that you fall down the rabbit-hole of customization. Part of why I designed my site to look like Craigslist is to resist that urge. And yet here we are, talking about how to implement [webmentions](https://www.w3.org/TR/webmention/) like it’s something folks have been asking me for. Here we go.

(If you know what webmentions are already, feel free to skip to “[How does it work?](#how-does-it-work)”. And if you don’t care how it works, skip to “[Pick a server](#1-pick-a-server)”).

### What is a webmention?

A webmention is a simple way to notify any URL when you mention it on your site. It’s like getting an @-mention on Twitter, except interoperable across any site. If Facebook and Twitter both supported webmentions, you could @-mention a Twitter user in your Facebook posts.

### How does it work?

When you @ someone on Twitter, your device sends a message to Twitter’s computers and says “Hey, I mentioned this person.” Twitter’s computers say “Cool, I’ll let them know.” Then, when the other person opens up Twitter on _their_ device asks Twitter’s computers “Yo, anything I should know?” and Twitter says “Yeah! Someone @-ed you.”

Webmentions works the same way, except its across _all_ websites, not just Twitter’s. So it takes one additional step. It doesn’t _know_ which computers store your mentions. So let’s say I want to mention your site funthings.com. My device will go to funthings.com and say “Aha! I see listed here that their mentions are stored at computer X.” Then my device goes to computer X and says “Hey, I mentioned this person.” Computer X says “Cool, I’ll let them know.” And the rest goes as you imagine. So in order for this to work, you need a computer that’s constantly running and listening to anyone who wants to send a mention.

If you have a static site, you probably _don’t_ have a computer X that’s always available to store messages from random people. This site currently runs on Github Pages which just serves files, it doesn’t accept new messages. So if you’re running a static site like I am, you need a slightly different approach.

### 1. Pick a server

If you have a server, go for it. But if you don’t, you need to find a webmentions service you can use. [Webmentions.io](webmentions.io) is an open source, free option. You sign in with IndieAuth and it’ll make an account for you. Easy peasy.

### 2. Follow setup instructions.

You’ll notice that in the Settings tab, webmentions.io gives you two link tags to put in your HTML header. (You can see that I put mine [here](https://github.com/person-al/person-al.github.io/blob/main/_includes/head.html#L18-L19) with the url stored in my [config file](https://github.com/person-al/person-al.github.io/blob/main/_config.yml#L31). I recommend that for the next step). This allows someone like me to come and ask “Hey, where’s your computer X?” and quickly find the answer. You’ll also notice that it gives you an RSS feed you can follow to track webmentions you receive. You can follow it in your RSS reader of choice, or even write some code to display the mentions on your site!

That’s all you need to do to _receive_ webmentions. But how do you support people _sending_ them? IndieWeb folks in the know have their own systems to send you webmentions, but what if you want to support a comments section on your site?

### 3. Create a comments section

Aaron Parecki has a [great post](https://aaronparecki.com/2018/06/30/11/your-first-webmention) on sending your first webmention and making it render right. At the bottom of his post, you’ll notice a little form. It says “Have you written a [response](https://indieweb.org/responses) to this? Let me know the URL:” and then has a place for you to paste your comment. While I haven’t seen any tutorials on how to do this, it’s actually something webmention.io supports for you.

If your username for webmention.io is x.com, visit `https://webmention.io/x.com/webmention`. You’ll see a form nearly identical to what you want on your site. With some slight tweaking of the html, you can get something like this:

```
<form action="{{site.webmention_link}}" method="post" target="_blank" style="margin-top: 16px;">
<label for="source">Comment by responding wherever you'd like and send me the URL:</label>
<input type="url" name="source" id="source" placeholder="The link to your comment" style="margin-bottom: 14px; width: 90%; display: block;">
<div hidden>
<label for="target">Link to the page you're commenting on:</label>
<input type="url" name="target" id="target" value="{{site.url | append: page.url}}" placeholder="The page your webmention is about (probably this page)" style="margin-bottom: 14px; width: 90%; display: block;">
</div>
<div style="margin-top: 16px;">
<input type="submit" class="button" value="Send Webmention">
</div>
</form>
```

Add that to the bottom of your post template and voila!

That’s all you need to enable people _sending_ comments to you. But what about _displaying_ those comments?

I’ve personally not chosen to do this yet. But there are a few tutorials online like [Deluvi’s](https://deluvi.com/blog/webmention/) or [Rowan Manning’s](https://rowanmanning.com/posts/webmentions-for-your-static-site/). If you’re looking for display inspiration, I recommend Maggie Appleton’s [site](https://maggieappleton.com/teenage-desktop).

**Info** :

- **Related to:**
  - [🌳 how I publish my Zettelkasten](/%F0%9F%8C%B3/2022/05/08/how-i-publish-my-zettelkasten.html)
  - [🌱 how to comment](/%F0%9F%8C%B1/2022/05/19/how-to-comment.html)
  - [[🌰 it’s not about writing, it’s about thinking]]
- [Also posted on IndieNews](https://news.indieweb.org/en)
