---
title: Notes from HOPE and DEF CON
date: 2022-08-15 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-15-notes-from-hope-and-def-con.html
author: 100007
---

Now that both HOPE and DEF CON are behind me, I want to summarize some of my initial thoughts. This is not a “what did I learn about hacking” post, but rather musings about _attending_ these events.

- [A New HOPE](https://xiv.hope.net/)
- [DEF CON 30](https://defcon.org/html/defcon-30/dc-30-index.html)

# Device Security

The internet is awash with advice to only bring burner phones/laptops to DEF CON (or hacker conferences in general), to assume any credit card you use while attending (or even being near) DEF CON is compromised, etc.

After much consideration, I’ve come to believe that much of this “advice” is ill-conceived, and shows either the advice-giver’s poor risk modeling abilities or inflated sense of their own importance. Rob Graham’s advice is much better: Encrypt your stuff and be careful about Wi-Fi and Bluetooth, and you’ll almost certainly be fine.

_Assuming that you’re using up-to-date devices_, the main risks of going to a hacker conference are the same as any sort of travel: Theft, assault, abuse by the local authorities. I’m not the kind of person who needs to worry as much about the second two of these, so theft is my main concern. Here’s my general travel setup, which I think is also pretty solid for hacker conferences:

- I _don’t_ take my regular computer with me. I travel with a recent iPad Pro and iPhone, and also bring along a Raspberry Pi (currently a 4B running Kali Linux - I have a guide covering how to set that up if you’re interested) in case I need tools I can’t run on the iPad (this is actually less common than you’d think).
- All of my devices are encrypted.
- I use Face ID on my iPad Pro and iPhone, but _not_ for the lock screen. A strong passcode or PIN is required for initial device access - I think of Face ID as an extra layer of security for individual apps rather than what provides the actual _device_ security.
- I run a minimal-ish set of applications, and regularly review and uninstall anything I’m not currently using.
- Before leaving (generally the morning I head for the airport, unless i have a _really_ early flight), I make sure that all of my devices are running the most up-to-date versions of their operating systems and apps, and run a complete backup.
- I have Find My active on all of my devices so if the device is stolen I can lock/wipe it remotely.
- Finally, I use Proton VPN on all my devices. I do this not for “privacy” reasons, but because using a VPN is a way to ensure that any applications that are _not_ using encrypted connections or are vulnerable to downgrade attacks have an extra layer of protection. That ProtonVPN also provides some on-the-wire malware blocking is an added bonus.

Now, hacker conferences _do_ generally have a more hostile radio frequency environment, so I do take extra care here.

- I turn off Bluetooth and leave it off attending the conference. Since I only travel with wired headphones, this isn’t a big hardship for me. The only time I turn on Bluetooth is if I want to edit any photography (I have an Apple Pencil for my iPad), but I only do this when away from the conference area.
- I remove all Wi-Fi networks from my devices (which means deleting them from iCloud Keychain). For DEF CON, I configure the secure conference conference Wi-Fi before leaving. That said, I keep Wi-Fi turned off on my devices as well unless I absolutely need it.

Finally, you want to be careful what you’re plugging into your devices. Personally, I bring my own cables and charger, and don’t use anything provided by another conference attendee or plug in any devices (for example, USB drives) that I didn’t bring with me.

There’s not some kind of magical “hacker miasma” at these conferences that puts your device at risk - someone looking to compromise your device needs to be able to get data to it. By limiting connections to radio networks and avoiding untrusted devices, the opportunity for an attack is severely curtailed (though it cannot be eliminated). The main risk here is someone attempting to subvert a trusted connection (the DEF CON secure Wi-Fi network, the Bluetooth connection to my Apple Pencil, or the cellular radio on my iPhone); the best defense is simply keeping your shit up-to-date and pre-configure trusted connections. It’s very unlikely that someone is going to burn a cellular zero day on you at a hacker conference.

If your risk model is that a nation state is gunning for you, then you need to be worrying about a lot more than just conference security! Needless to say, this guide is not, then, for you.

- [Securing devices for DEFCON](https://blog.erratasec.com/2019/08/securing-devices-for-defcon.html)
- [Apple iPad Pro](https://www.apple.com/ipad-pro/)
- [Apple iPhone](https://www.apple.com/iphone/)
- [Raspberry Pi](https://www.raspberrypi.com/)
- [Use a Raspberry Pi 4B as an iPad Pro Hacking Accessory](https://cardboard-iguana.com/notes/use-a-raspberry-pi-4b-as-an-ipad-pro-hacking-accessory.html)
- [Apple Find My](https://www.apple.com/icloud/find-my/)
- [Apple Pencil](https://www.apple.com/apple-pencil/)
- [Proton VPN](https://protonvpn.com/)
- [DEF CON Wi-Fi Registration](https://wifireg.defcon.org/)

## A Note About Credential Management

An important layer of defense at hacker conferences, when traveling, or just _in life_ is good credential management.

I use different usernames/emails for almost every service. Both Proton Mail and Google Workspace can be configured with catch-all email addresses. If you don’t want to pay money, then sign up for Gmail and liberally use the `+` functionality.

Use unique, random passwords for as many services as you can. Use a password manager (KeePassXC and compatible applications are good choices) to make this easy to manage. Don’t store these credentials in your browser or system keychain.

Set up multi-factor authentication on _every_ account that supports it. Whenever possible, use a hardware key (like a YubiKey). As a bonus, you can use hardware security keys to further lock down access to your password manager: Do this using either built-in support, or by storing a long random string in one of your security key “slots” and then using this _in addition to_ a string that you’ve memorized to access your password vault (full-featured YubiKeys - not the lower-end “security keys” Yubico sells - support both options).

- [Proton Mail: What is a catch-all email address?](https://proton.me/support/catch-all)
- [Email routing and delivery options for Google Workspace](https://support.google.com/a/answer/2685650)
- [Gmail: Create task-specific email addresses](https://support.google.com/a/users/answer/9308648)
- [KeePassXC](https://keepassxc.org)
- [YubiKey 5 Series](https://www.yubico.com/products/yubikey-5-overview/)
- [KeePassXC User Guide: Database Settings](https://keepassxc.org/docs/KeePassXC_UserGuide.html#_database_settings)

# Packing

I’m a light packer, partly because I don’t like checking bags, and partly because I enjoy the challenge. This year I managed to fit all of my gear into a single Peak Design 20 L Everyday Backpack (with the help of two small packing cubes). However, this is all a tight fit - there’s next to no room for conference swag on the return trip, and the laptop compartments are compressed more than I’m comfortable with. Moving forward, I intend to switch to a Peak Design 30 L Everyday Backpack, as I think that the extra 10 L should be more than enough for me.

There’s enough (low profile) pockets in the Peak Design Everyday backpack that I don’t need a cord bag, and it’s a reasonable size to use as a day bag at the conference itself. This requires some unpacking/repacking at the hotel, but that’s a small price to pay to avoid having to carry an entire additional bag. Peak Design products are a bit pricy, but I’ve experimented with _a lot_ of different bags over the years and they’re hands-down the most durable, versatile bags I’ve ever owned.

One thing that’s enables me to pack light is that I’ve moved away from wearing jeans. Instead, I’ve switched to Bluffworks’ Ascender 5-Pocket Pants, which are tough, light, wrinkle-resistant, _very_ compressible, and have the bonus of being much harder to pick pocket than most other mens’ pants (though again, a determined thief can still defeat them). I pair these with Icebreaker underwear and socks, which are also exceptionally light and durable. Bluffworks also makes travel blazers and other outfits for less casual situations; these are also good for traveling light, but by necessity take up a bit more space. There’s a trade-off between looking nice and packing light that is just difficult to navigate.

One disadvantage of this setup is that it’s difficult to bring multiple pairs of shoes. I opt to just wear a pair of black running shoes - they’re not dress shoes, but they’re comfortable and sufficiently understated that you can get away with using them in less casual situations in a pinch.

- [Peak Design Everyday Backpack](https://www.peakdesign.com/products/everyday-backpack)
- [Peak Design Packing Cubes](https://www.peakdesign.com/products/packing-cube/)
- [Icebreaker Men’s Underwear](https://www.icebreaker.com/en-us/mens-underwear)
- [Icebreaker Men’s Socks](https://www.icebreaker.com/en-us/mens-socks)
- [Bluffworks Gramercy Blazer](https://shop.bluffworks.com/products/gramercy-blazer-classic-fit-blue-hour)
- [Bluffworks Performance Suites](https://shop.bluffworks.com/pages/performance-suits)

# At the Con

At the conference, or really when traveling in general, I try to avoid being conspicuous. I don’t wear conference swag/merch. I don’t put stickers on my devices. I take off my conference badge and put it in my backpack when it’s not required. I don’t flash (or carry) big wads of cash.

In short, I try not to _look_ like a target. Ideally, there should be no way for someone who sees you outside of the conference to know that you are an attendee.

## A Note on Masks

I don’t like wearing masks, but if I’m going to wear one I’m going to wear an _effective_ one. Since HOPE and DEF CON were both masked events, I brought along tight-fitting N95 masks for use while attending the conference.

The problem with a well-fitted N95 masks is that they’re kind of a pain to take off. This makes both eating and (more importantly) drinking a less attractive proposition. I wound up going back to my hotel to do both during the day, which created larger gaps in my schedule than I planned.

Moving forward, I don’t think it makes sense to bring a water bottle to any events that have a mask requirement. I also need to remember that I can’t effectively pull off my normal back-to-back-to-back event schedule at conferences with mask requirements. This means doing _less_ at these events than I otherwise would, but _c’est la vie_ in the time of plague.

- [BNX N95 Mask Respirator (NIOSH)](https://bnx.com/products/n95-mask-black-made-in-usa-bifold-h95b/)
