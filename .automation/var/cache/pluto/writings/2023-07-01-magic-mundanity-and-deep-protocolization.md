---
title: Magic, Mundanity and Deep Protocolization
date: 2023-07-01 00:07:56.000000000 Z
layout: post-external
original_link: https://studio.ribbonfarm.com/p/magic-mundanity-and-deep-protocolization
author: 100041
---

_This essay is part of the [Mediocre Computing](https://studio.ribbonfarm.com/p/mediocre-computing) series_

In some commentary on the Apple VisionPro, a few people have noted an interesting point: While the device clearly uses a lot of sophisticated AI, nowhere in the messaging around the new gadget is the term AI used. This seems generally true of Apple products. They use AI but never talk about their products in AI terms.

This strikes me as more than a sound (and very Apple) design and marketing approach. It reflects a sound understanding of the nature of AI — as an uncredited and formless _modifier_ of other technologies. One whose presence is marked by familiar behaviors having slightly magical effects.

You click as usual, but the responses are subtly, magically, enhanced. You take a photograph, and it looks like it was taken by a professional rather than the sloppy amateur you are.

In the case of Apple, the power of AI is often cashed out via anticipatory user experiences. Matt Webb [called this](https://interconnected.org/home/2023/06/09/future) “computers that live two seconds in the future.” Like the Sirus Cybernetics elevators in _Hitchhiker’s Guide,_ which could sense danger in the near future and go hide in the basement, AI can allow technologies to operate in the very near future (or more accurately, hack the fact that our brains live in the very near past — conscious experience is somewhere between milliseconds to tenths-of-seconds behind the unconscious sensory edge of our nervous systems).

## Magic Sauce

There are other ways to cash out the power of AI besides living 2 seconds in the future. Think text editors that quietly polish your text into a preferred style as you type, rather than requiring you to be in a prompting dialogue with a chatbot or agonizing over templates and shortcuts. Think image editing software that interprets your design intentions like a benevolent expert designer, showing you filtered context menus you didn’t know you needed, rather than, again, putting you in a prompting dialogue with an ersatz person. Think Doc Ock’s mind-hijacking arms in Spider-Man 2, a case of medium-is-the-message effects on steroids.

Nudge technology as conceived by behavioral economists turned out to be [irreproducible nonsense](https://www.pnas.org/doi/10.1073/pnas.2200300119), but nudge technology as embodied by AI will be real, and beyond anything Sunstein and Thaler dreamed of. Sometimes this will mean everything being reduced to premium-mediocre stock-photo banality (I imagine entire movies that feel like the [Balenciaga meme](https://goldsguide.com/ai-memes-by-balenciaga-how-to/) will not be fun). Other times, it will mean more sublime experiences. Sometimes this will feel subtly hostile and malicious. Dark magic. Other times, it will feel subtly friendly and benevolent. Light magic.

I suspect though, in all such cases, the presence of mature AI in the technology will never be an _invisible_ presence.

When it works well, it will always add a noticeable degree of magical augmentation to our sense of our own agency. The world will feel less like one governed by impersonal and indifferent laws of physics, and more like one governed by an opinionated essence extending and subtly modifying our felt sense of agency.

When it _doesn’t_ work well, AI won’t feel magical, in either light or dark ways. It will merely feel irritating, awkward and embarrassing, like much of Sirius Cybernetics technology in _Hitchhiker’s Guide_. Like a magician who fumbles a trick, breaking the illusion. Or like one of those slightly irritating friendly people who think they are in a mind meld with you and can finish your sentences, but cannot, and routinely get it wildly not-even-wrong. Ducking autocorrectors personified. Or like one of those dangerously clueless people who says the quiet part out loud in difficult conversations.

Chatbots and prompt-based workflows are, I suspect, a transient phase, as is the under-the-API “tagging” phase of tedious human-in-the-loop model-training work.[1](#footnote-1) We might still have AI-powered artificial life forms in our future (and taggers in Nairobi breathing life into them), but they will become an increasingly marginal use case. The main act will be an overlay of magical behavioral tendencies and dispositions gradually wrapping itself around all our familiar everyday technology.

AI is magic sauce for all technological _affordances_. It will turn [manufactured normalcy](https://www.ribbonfarm.com/2012/05/09/welcome-to-the-future-nauseous/) into magical normalcy.

## Mundanity Sauce

There is another technology that has been evolving equally rapidly; one that _also_ acts primarily as a somewhat formless and uncredited modifier of other technologies: protocols. Specifically, _modern_ protocols that make use of things like public-key cryptography, Merkle trees, and zero-knowledge proofs. Blockchains are the prototypical examples of such modern protocols, but not the only ones.

To take the currently most talked-about application domain as an example, Twitter clones, ActivityPub (the protocol behind Mastodon), Farcaster, and AT Protocol (the protocol behind Blue Sky) all attempt to “protocolize” the experience of Twitter with varying degrees of success.

But here, the transformative effect is different. Instead of adding a subtly magical overlay to the effects of interactions, protocols reveal their presence by quietly lowering or eliminating friction across the overall experience of using a technology.

This is a strong claim, and one that can seem wrong on the face of it because we tend to see friction in a system in a fragmented way, focused especially on routine, frequent behaviors, rather than across _all_ the system’s behaviors, including rarely triggered but highly consequential ones. With blockchain technologies, for instance, the entire user experience can seem higher-friction than comparable older technologies.

The trick is that friction must be considered across _all_ use cases, not locally in time or system space. In the case of protocolized Twitters, all eliminate some friction in controlling your own data and feed experience, but in some cases introduce more friction around more routine behaviors.

The feel of lowered friction is that sometimes, when you expect _motivated_ resistance and jankiness from the system, such as in canceling a subscription, and where you perhaps even expect to _fight_ it or _subvert_ it a little, things go surprisingly, even suspiciously smoothly. You’re prepared to fight but are left with nothing to fight, nothing to subvert. A zone of conflict and contention has been turned into a zone of smooth coordination.

But all frictionlessness is not the same. Consider Apple once again, which is actually great at delivering a limited kind of frictionlessness.

For example, when you buy a new Apple computer, and want to transfer your data from the old one, the Migration Assistant works almost alarmingly smoothly (at least it has, for me). A couple of simple steps, and then everything gets ported over, and the new computer works just like the old one, down to cached passwords for websites. This is radically different from the experience of setting up Windows PCs (at least in the past) and especially Linux computers (even today).

It is especially unsettling when you port from the older Intel-based Macs to the new Apple silicon. You _expect_ things to go wrong, but unless you are an extreme power-user doing exceptional things with your computer, they generally don’t. Everything works, and the few laggard programs (like Dropbox when I migrated) that haven’t been ported yet start running on an emulator called Rosetta. The only sign that a radical change has occurred at the hardware level is that Rosetta programs seem to draw more battery power, and exhibit slightly laggy behavior. Which you either won’t notice, or if you do, will blame on a poorly maintained/updated client program rather than Apple host infrastructure.

Now that’s definitely the _feel_ of protocolization. A familiar high-friction experience turned into a weirdly frictionless one. But is it the real deal?

There are other examples in the Apple universe: Airdrop, Airplay, browser tabs automatically appearing across your multiple devices. Once you get used to each bit of unexpected frictionless behavior, you come to _expect_ it as the default. And the more you _get_ it, the more unconscious the expectations become. The protocolization creates new “water” for you, in the sense of David Foster Wallace’s _[This is Water](https://fs.blog/david-foster-wallace-this-is-water/)_ speech.

But Apple’s version of protocolization is _faux-_protocolization, because it controls the entire user experience on its platforms dictatorially, and you only get this kind of frictionlessness where it is in Apple’s interests to provide it. In our household, we currently have 6 Apple devices that work together beautifully, But they are all controlled by the One Ring in Cupertino.

The _cost_ of such control is irrelevant for _most_ people _most_ of the time, but when it does matter, like when you try to develop and deploy apps that bring their own economic logic to the party, a new battlefront in World War Apple opens up. There is a reason Apple’s _faux-_protocolized frictionlessness has created three major battle fronts against the rest of the tech industry: with gaming (Fortnite), social media (Facebook/Meta), and crypto (Uniswap, Coinbase apps, token-gated access models).

This is _faux-_protocolization. Friction removed where it helps Apple, and cranked up to infinity, entirely blocking classes of experiences, where it threatens Apple.

There are those who see the problems with the One Ring existing, and those who seem to perversely not get it, pretending that the frictionlessness of the Apple universe is somehow free; an unencumbered kind of consumer surplus blessed by the ghost of Steve Jobs, rather than a deal with a devil that works for some people, some of the time.

A good way to understand Apple-style _faux-_protocolization is via the political slogan _just because it works for you doesn’t mean it works._

Much of the politics of the blockchain world, around loaded ideas like decentralization, permisionlessness and censorship resistance, is focused on situations where non-protocolized and _faux-_protocolized technologies fail (especially for disempowered groups), or only work by the grace of the unreliable benevolence of an unquestioned authority.

These situations may be rare, but when they occur, they are highly consequential and politically charged. You don’t port your data from one service to another everyday. Not everybody needs to tune their social feeds in a way that a centralized algorithmic authority resists or blocks. But when you _do_ need such functionality, it is often critical.

Often, protocolized technologies feel _more_ high-friction in day-to-day usage than the technologies they replace, because they refuse to cede political agency on the rare occasions it is needed, in return for increased day-to-day convenience. Considered overall, across both routine and rare use cases, protocolized technologies arguably deliver _net_ lowered friction. It’s still a deal with a devil, but arguably a more honest devil that demands a smaller piece of your soul.

In other words, protocolized technologies attempt to loosen the Industrial-era convenience-vs-sovereignty tradeoff. They attempt to deliver more day-to-day convenient technological agency without surrendering political agency during rarer critical situations.

This is generally regarded as the mission of true protocolization. Real-world protocolization processes may not always live up to this ideal, but non-protocolized and faux-protocolized technologies do not even try, and usually attempt to actively block the possibility.

So what is _true_ protocolization?

> True protocolization is when you get unexpected frictionlessness in an _open_ technological context when dealing with _unrelated_ but _entangled_ entities in concert, _without_ ceding rarely needed but critical political agency elsewhere.

In other words, protocolization is when things get more convenient, but you don’t have to give up additional political agency for it.

Blockchains are an existence proof that this is actually technologically possible, but I’m open to the the idea that there may be more than one pattern of true protocolization possible.

My first startling experience of true protocolization was in my initial experiences with Ethereum wallet sign on. Thanks to global onchain data, my interactions with one dApp were modifying my experience on other dApps. I buy an NFT here, it shows up there. It felt weird in the way experiencing Facebook and Google working seamlessly together would.

What is interesting about this is that unlike with AI, the magic rapidly dissipates into completely invisible mundanity. In fact, the only time you notice the protocolization is when you return to older experiences that _haven’t_ been protocolized in the same way, and suddenly what once seemed like an unalterable condition in the world starts to seem like unacceptable friction, or worse, artificially constructed and maintained impossibility.

Once you’ve experienced wallet sign-on (or more generally, any kind of private-key-based authentication), tolerating traditional password management workflows involving sketchy servers run by incompetents seems absurd. This [password game](https://neal.fun/password-game/) I came across today highlights some of the more visible absurdities, but it’s just the tip of an iceberg of absurdities designed to externalize all the risks of security infrastructure, managed under severe moral hazard, onto you.

Of course, wallet sign-on has its own problems. You can be scammed into signing transactions that steal things from you (which I’ve experienced, though fortunately only for a minor amount). You can lose your private keys. But at least, in such cases, you mostly have only your own carelessness to blame.

Being scammed, or losing a private key and the assets it controls, is no fun. But it beats receiving yet another email from a poorly managed service announcing a major data exfil event that included your personal information, and offering you yet another year of “identity-theft protection” services.

Being caught up in endless security theater of this sort feels increasingly unnecessary as you gain some literacy in key-management and start to own your risks.

The sense of reduced friction and better managed risks is strongest in relation to security-related behaviors, but is evident anywhere protocolization is underway.

For example, once you’ve started playing even a little bit with the customizable feeds of Farcaster and Bluesky, the rigidity of the Twitter algorithm seems like horrifying autocracy. Custom feeds is a relatively recent development, but already feels like the natural way for such technologies to work. Why on earth have we been arguing with Twitter management about how feeds should behave? It’s now obvious that we shouldn’t need anyone’s permission to design our feed to our own tastes. The only force that has the right to stop us is our own laziness and apathy.

Or to take a more mainstream example, once you’ve used the Global Entry and TSA Precheck systems for flying within and into the US, normal procedures for clearing airport security and immigration seem like torture. While this too is _faux-_protocolization _a la_ Apple, it feels less oppressive because the surveillance state already knew everything about me anyway, and the _marginal_ ceding of political agency here, at least in my case, was zero (they had my fingerprints in a federal database already, thanks to the naturalization process, so I had to give them no additional information to get Global Entry. Just $20/year).

We’re not there yet, with regard to the grand promise of frictionlessness without political submission. As with AI, we’re in a transient stage.

Where the transient stage of AI is marked by having to deal with chatbots and image generators in a somewhat awkward “prompting” language (and for those under the API, a “tagging” grindwork), the transient phase of modern protocols involves overheads of _configuration_ and _custody._

You get the invisibly frictionless mundanity _only_ if you first adopt a few good configuration and self-custody disciplines. Otherwise you get the worst of both worlds — you _don’t_ eliminate the friction, _and_ you are exposed to all the risks and none of the rewards of self-custody.

As with AI, mitigations are in the works. People are working on safer models of private-key custody, social patterns for key-recovery, easier configuration models, and so on.

But the headline takeaway is clear: Protocols are mundanity sauce for all technological _friction._

And _modern_ protocols that use post-blockchain technologies are _sovereignty-preserving_ mundanity sauce for a growing class of technological friction.

Put magic and mundanity together, and you get the _yin-yang_ technological force that is starting to transform everything.

In fact, I’m tempted to define my umbrella idea of mediocre computing as computing that is at once magical and mundane.

What is the advent of this pair of technologies doing to the world?

[Read more](https://studio.ribbonfarm.com/p/magic-mundanity-and-deep-protocolization)

