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

The [Webmention site](https://indieweb.org/Webmention-developer#Protocol_Summary) has a clear walkthrough, but in the context of commenting[1](#fn:1) you can think of it like this:

[![Diagram of the above](https://mermaid.ink/img/pako:eNp1kTFPw0AMhf-K64WBlAEEww1FlRhgyEQXpCzWxSWn5s7hzkcVVf3vXAgUEKon68l-n_x8QCsto8HEb5mD5QdHr5F8E6DUuneWLxIMnQRerlaXm71T5VikxPGdYzLwyHEa8SNY8Z6DggQYJCnc3F7fLWajf3vFbPnH3cCmo7BLXwu1oxP3LHiswFKAp6LxD_L-HHJi_vI18JKHBdS0Y0g5MqgA9UkgdbIH7Vw6XbSN4ucwrrBCz9GTa0tohwnVoHbsuUFT2pa3lHttsAnHMkpZ5XkMFo3GzBXmoSX9zhjNtvCKyq1TifX8iM9_HD8AmXeIiw?type=png)](https://mermaid.live/edit#pako:eNp1kTFPw0AMhf-K64WBlAEEww1FlRhgyEQXpCzWxSWn5s7hzkcVVf3vXAgUEKon68l-n_x8QCsto8HEb5mD5QdHr5F8E6DUuneWLxIMnQRerlaXm71T5VikxPGdYzLwyHEa8SNY8Z6DggQYJCnc3F7fLWajf3vFbPnH3cCmo7BLXwu1oxP3LHiswFKAp6LxD_L-HHJi_vI18JKHBdS0Y0g5MqgA9UkgdbIH7Vw6XbSN4ucwrrBCz9GTa0tohwnVoHbsuUFT2pa3lHttsAnHMkpZ5XkMFo3GzBXmoSX9zhjNtvCKyq1TifX8iM9_HD8AmXeIiw)

Let’s say Alice uses her phone to comment on Janet’s tweet.

1. Alice’s phone talks to Twitter’s computers and says “Hey! I’m Alice, here’s my comment on post 3526.”
2. Twitter’s computers say “Got it, thanks!”
3. Later, when Mia’s phone goes to look at her tweet, it asks Twitter’s computers “Hey, I’d like to look at post 3526.”
4. Twitter’s computers say “Okay! Here’s the text and here are all the comments, including this one from Alice!”

[Webmentions](https://indieweb.org/Webmention-developer#Protocol_Summary) works the same way, except its across _all_ websites, not just Twitter’s. So it needs to take one additional step. Let’s assume again that Alice is using her phone to send a webmention:

[![Diagram of what's shown above](https://mermaid.ink/img/pako:eNp1kkFvwjAMhf-Km8sOA3bvgWnSDtskTuywSb2ExKVhTdwl7lCF-O9z6YqAQU-R7b73_Mk7ZciiylXC7xaDwWen11H7IoB8T7UzeJegqSjgdD6_f9MBWQpbXCXHmMMLdhOwBB21oI3Bhvuex8COQnocZC7-EqHpmXIOn5gyWGKw4BiY5Bl_MMLHjRhj-8-_wti3fQeGfO8NJcWja0OJQUuu7Xa26WszmXroZhX7etAf5a4Ee690-ErZMLdw-pjiNg2jA7xCQoTB4yaEyzXWJDlDdwrwsMiZzGlW-BdAOB5xSEooI_kBX3Y9RS9zstY50ME4Ewg4kk2gI_Y0WWorYiYvymqiPEavnZVL2vVOhZIBj4XK5Wmx1G3NhSrCXkZ1y7TsglE5xxYnqm2s5vHwVF7qOkkVrWOKi-E6D0e6_wUnmuPs?type=png)](https://mermaid.live/edit#pako:eNp1kkFvwjAMhf-Km8sOA3bvgWnSDtskTuywSb2ExKVhTdwl7lCF-O9z6YqAQU-R7b73_Mk7ZciiylXC7xaDwWen11H7IoB8T7UzeJegqSjgdD6_f9MBWQpbXCXHmMMLdhOwBB21oI3Bhvuex8COQnocZC7-EqHpmXIOn5gyWGKw4BiY5Bl_MMLHjRhj-8-_wti3fQeGfO8NJcWja0OJQUuu7Xa26WszmXroZhX7etAf5a4Ee690-ErZMLdw-pjiNg2jA7xCQoTB4yaEyzXWJDlDdwrwsMiZzGlW-BdAOB5xSEooI_kBX3Y9RS9zstY50ME4Ewg4kk2gI_Y0WWorYiYvymqiPEavnZVL2vVOhZIBj4XK5Wmx1G3NhSrCXkZ1y7TsglE5xxYnqm2s5vHwVF7qOkkVrWOKi-E6D0e6_wUnmuPs)

1. Alice’s phone goes to Janet’s website and says “We have a comment! Does your site support webmentions?”
2. Janet’s website replies “Yes! Send them to computer X”
3. Alice’s phone then goes to Computer X and says “Here is my comment for Janet’s post at url `www.janet.com/y.html`”.
4. Computer X says “Got it, thanks!”
5. Mia goes to Janet’s website and asks “Can you render `www.janet.com/y.html`?”
6. Janet’s website quickly goes to Computer X: “Hey, got any webmentions for me?”
7. Computer X: “Yup! Alice wrote this.”
8. Janet’s website then responds to Mia’s phone: “Yup! Here’s `www.janet.com/y.html`! I’ve rendered the comments at the bottom.”

If you have a static site, you probably _don’t_ have a computer X that’s always available to store messages from random people. This site currently runs on Github Pages which just serves files, it doesn’t accept new messages. So if you’re running a static site like I am, you need a slightly different approach.

### 1. Pick a server

If you have a server, go for it. But if you don’t, you need to find a webmentions service you can use. [Webmentions.io](webmentions.io) is an open source, free option. You sign in with IndieAuth and it’ll make an account for you. Easy peasy.

### 2. Follow setup instructions.

You’ll notice that in the Settings tab, webmentions.io gives you two link tags to put in your HTML header. (You can see that I put mine [here](https://github.com/person-al/person-al.github.io/blob/main/_includes/head.html#L18-L19) with the url stored in my [config file](https://github.com/person-al/person-al.github.io/blob/main/_config.yml#L31). I recommend that for the next step). This allows someone like me to come and ask “Hey, where’s your computer X?” and quickly find the answer. You’ll also notice that it gives you an RSS feed you can follow to track webmentions you receive. You can follow it in your RSS reader of choice, or even write some code to display the mentions on your site!

That’s all you need to do to _receive_ webmentions. But how do you support people _sending_ them? IndieWeb folks in the know have their own systems to send you webmentions, but what if you want to support a comments section on your site?

### 3. Create a comments section

Aaron Parecki has a [great post](https://aaronparecki.com/2018/06/30/11/your-first-webmention) on sending your first webmention and making it render right. At the bottom of his post, you’ll notice a little form. It says “Have you written a [response](https://indieweb.org/responses) to this? Let me know the URL:” and then has a place for you to paste your comment. While I haven’t seen any tutorials on how to do this, it’s actually something webmention.io supports for you! You can see my version at the bottom of this page.

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

1. Webmentions allow you to do everything from comment to like to bookmark, and more! We’ll talk strictly about commenting for now, but if you replace the word “comment” with “like” in this section, it’s all still true. [↩](#fnref:1)

