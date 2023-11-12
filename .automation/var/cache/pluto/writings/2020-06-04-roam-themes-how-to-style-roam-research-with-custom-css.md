---
layout: post-external
title: |
  Roam themes: how to style Roam Research with custom CSS
date: 2020-06-04 02:00:00 +0000
author: 100071
original_link: https://nesslabs.com/roam-research-themes-custom-styling-css?utm_source=rss&utm_medium=rss&utm_campaign=roam-research-themes-custom-styling-css
---

One of the most exciting aspects of Roam Research is metaprogramming: the ability to modify Roam’s behaviour inside Roam itself, without ever touching the source code. This ability opens the door for building custom algorithms for thoughts, and designing a thinking environment as close as possible to the way your mind works. Using CSS to styling Roam with a custom theme is just another way to map the way your Roam database works to your own thought processes.

The best thing? Whether you know how to use CSS—which stands for Cascading Style Sheets and basically describes how elements are to be displayed on screen—you will be able to install custom themes in Roam. Let’s go through these steps together.

## 1. Create a new page for your CSS

The first thing you need to do is to create a new page which will be housing your custom styles. The new page should be named `roam/css` — make sure it’s all lower case, with no extra space.

![Roam themes - create roam/css page to install custom css](https://nesslabs.com/wp-content/uploads/2020/06/roam-research-custom-css-1-1024x544.png)
_Create roam/css page to install custom CSS_

That’s it for the first page. In the future, any new styles you want to use will need to be added to this page, and not anywhere else.

## 2. Add CSS to the page

Now that your styles page is created, let’s make some magic with it. You need to follow these three steps to add and activate custom CSS to your Roam database.

- The first block (bullet point) should have the name of your theme as a bracketed link. For instance, my theme is called `[[Roamness]]`. This is not technically mandatory but will allow you to easily turn the theme on and off in the future.
- The second block should be an indented code block with your CSS. Just paste ````Your CSS here```` in the second block and press enter. Then, replace the placeholder text with your actual CSS. Please make sure the code block is indented under the first block so you can easily turn the theme on and off.
- Finally, you need to turn the block type to CSS. Boom—your Roam database will now be styled with the CSS you added to the second block.

![Install custom CSS](https://nesslabs.com/wp-content/uploads/2020/06/roam-research-custom-css-2.png)
_Create dedicated blocks to house the custom styles_

## 3. Turning a theme on and off

If you are sharing a database with other people, or if you are recording a demo video and need the vanilla theme, you may want to turn your theme off for a while.

To do so, go to the `roam/css` page you created in the first step, click on the filter icon in the top right corner of the page (in the top bar), and `SHIFT + CLICK` on the name of your theme to filter it out.

To turn it one again, go to the page, click on the filter icon, and `SHIFT + CLICK` again on the name of the theme.

![](https://nesslabs.com/wp-content/uploads/2020/06/roam-research-custom-css-3.png)
_Turn themes on and off with the filter function_

Another way you can turn themes on and off is by changing the type of the code block from CSS to something else, such as HTML or JavaScript, so the code is not interpreted any longer.

## 3. Add pre-styled themes to Roam

Don’t want to code your own theme? Don’t know how to use CSS? Fear not, you can install Roam themes from the [gallery.](https://roamresearch.com/#/app/help/page/fJRcVITNY)

Click on the question mark at the top right of the screen, then click on “Help Database” to open the documentation. Then, in the search bar, type “Roamcult Themes” to access the gallery, which features screenshots and CSS code for several themes.

Navigate to a theme you like, copy the CSS, and paste it in the `roam/css` page in your own database. Make sure the code block’s type is CSS.

If you’re a writer or content creator and want a theme designed for content creation, I created [Roamness](https://nesslabs.com/roamness-roam-research-theme), which you will find in the themes gallery. 

![Roamness custom theme for Roam Research](https://nesslabs.com/wp-content/uploads/2020/06/roamness-screenshot-1024x604.png)
_Roamness: a theme for content creators_

And if you are more of a visual person, Conor White-Sullivan put together a video walkthrough detailing each step to install custom CSS to style your Roam Research database. Have fun!

The post [Roam themes: how to style Roam Research with custom CSS](https://nesslabs.com/roam-research-themes-custom-styling-css) appeared first on [Ness Labs](https://nesslabs.com).
