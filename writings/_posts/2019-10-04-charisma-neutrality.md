---
layout: post-external
title: Charisma Neutrality
date: 2019-10-04 20:15:44.000000000 Z
author: 100041
original_link: https://breakingsmart.substack.com/p/charisma-neutrality
---

Today I want to talk about a possible emerging successor to net neutrality, which I call charisma neutrality, which I think is a plausible consequence of a very likely technological future: pervasive end-to-end encryption. (17 minutes)

[![](https://cdn.substack.com/image/fetch/w_1456,c_limit,f_auto,q_auto:good/https#3A#2F#2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com#2Fpublic#2Fimages#2F5096d1ce-0eb9-44c5-b94d-95c7b9ef352a_908x720.png)](https://cdn.substack.com/image/fetch/c_limit,f_auto,q_auto:good/https#3A#2F#2Fbucketeer-e05bbc84-baa3-437e-9518-adb32be77984.s3.amazonaws.com#2Fpublic#2Fimages#2F5096d1ce-0eb9-44c5-b94d-95c7b9ef352a_908x720.png)

Now net neutrality of course, was part of a very important chapter in the history of technology. Though the principle is now pretty much down for the count, for a few decades it played a hugely important role in ensuring that the internet was born more open than closed, and more generative than sterile.

Even though the principle was never quite as perfectly implemented as some people imagine, even when there was a strong consensus around it, it did produce enough of a systemic disposition towards openness that you could treat it as more true than not.

That era has mostly ended, despite ideological resistance, because even though it is a solid idea with respect to human speech, it is not actually such a great idea relative to the technical needs of different kinds of information flow. So as information attributes — stuff like text versus video, and real-time versus non-real-time — began to get more varied, the _cost_ of maintaining net neutrality in the classic sense became a limiting factor.

And at least some technologists began seeing the writing on the wall: the cost of net neutrality was only going to get worse with AI, crypto, the internet of things, VR and AR.

What was good for openness and growth in the 1980s and 90s was turning into a significant drag factor by the aughts and 10s.

What was good for growing from 2 networked computers to a several billion was going to be a real drag going from billions to trillions.

I think there’s no going back here, though internet reactionaries will try.

To understand why this happened, you have to peek under the hood of net neutrality a bit, and understand something called the end-to-end principle, which is an architecture principle that basically says all the smarts in a network should be in the end point nodes which produce and consume information, and the pipes between the nodes should be dumb. Specifically, they should be too dumb to understand what’s flowing through them, even if they can see it, and therefore incapable of behaving differently based on such understanding. Like a bus driver with face-blindness who can’t tell different people apart, only check their tickets.

Now, for certain regimes of network operation and growth, the end-to-end principle is very conducive to openness and growth. But ultimately it’s an engineering idea, not divine gospel, and it has limits, beyond which it turns into a liability that does not actually address the original concerns.

To see why, we need to dig one level deeper.

The end-to-end principle is an example of what in engineering is usually called a _separation_ principle. It is a simplifying principle that limits the space of design possibilities to ones where two things are separate. Another example is the idea that content and presentation must be separated in web documents. Or that the editorial and advertising sides of newspapers should be separate. Both of these again got stressed and broken in the last decade.

Separation principles usually end up this way, because there’s more ways for things to be tangled and coupled together than there are for them to be separate. So it’s sort of inevitable that they’ll break down, by the law of entropy. Walls tend to leak or break down. It’s sort of a law of nature.

Whether you’re talking about walls between countries or between parts of an architecture, separation principles represent a kind of reductive engineering idealism to keep complexity in check. There’s no point in mourning the death of one separation principle or the other. The trick is to accept when the principle has done its job for a period of technological evolution, and then set it aside. But that doesn’t mean you can’t look for new separation principles to power the next stage of evolution.

One such principle has been emerging in the last decade: the end-to-end encryption principle.

The similarity in names should suggest that we’re talking about a cousin of the original end-to-end principle, and you would be right to think that. Here, what you’re saying is that only the end points in a network should be able to code and decode messages, and the pipes should not.

If you think about it, this is a loosening and generalization of the original end-to-end principle. The pipes now don’t have to be dumb, but only the endpoints can control what the pipes can know, and therefore what they can do on the basis of knowledge. The pipes are not dumb, but the endpoints are in charge. Instead of a bus driver with face blindness, all riders are now wearing masks, but their tickets can now contain any information they _choose_ to share, and the bus driver can act on that information.

As with the original end-to-end principle, the idealized notion is messy in practice. I was talking to some friends who are more tech savvy about this than I am, and they pointed out that an endpoint device itself is effectively a tiny unencrypted network, with more than one computer, and that the pipes in the intra-device network lie outside the scope of this principle.

So for example, you can have an extra invisible chip installed by the carrier, or something in the OS that traps what you’re typing before it gets to the encryption layer. And of course private keys can get exfiltrated without your knowledge. Maybe in the future end-to-end encryption will apply to the internal environment of every endpoint device, recursively all the way down to every logic circuit. But we’re not there yet.

And even without going there, it’s obvious the principle is not watertight anyway. Today, routers can peek inside packets, but in the future, even if they can’t, they’ll be able to tell a lot simply from the geometry of the connection and transmission patterns, even with technologies like VPNs and zero-knowledge proofs in the mix.

The thing is, different types of communication have different external heat signatures, and with AI, the ability to make inferences from such signatures will improve. It will be an arms race. The question will be whether pipes can get good at reading heat signatures faster than endpoints can get good at full-stack encryption that is secure in practice, not just theory.

There is no such thing as perfect containment of information. That’s another law of physics. Actually it is another form of the same law that tells you walls always break down.

So yeah, the technology is messy, but I think it already works well enough that it will create a broad tendency towards this new end-to-end principle being more true than false. You will never be able to hide from the NSA or the FBI or the Chinese government perfectly, but you can make it very much more expensive for them to monitor what you’re up to.

Now, this new end-to-end principle is also based on a separation principle. I’m not entirely sure how to characterize it, but I think end-to-end encryption attempts to make an approximately clean separation between _custody_ of data and _control_ of data, and tries to ensure that no matter who has custody, the owner has control over usage. We’ll see how well it works in practice as it becomes more widespread.

Now for the real question. Assuming the principle holds more often than not, and is more a _de facto_ default than an opt-in exception that only libertarian crackpots use, what does an internet based on end-to-end encryption look like?

I think what end-to-end encryption sustains, that is worth enshrining as a new value for this next chapter of evolution, is _charisma neutrality_.

What do I mean by that?

Well, I talked about [technological charisma](https://breakingsmart.substack.com/p/technological-charisma) a few weeks ago, but here I’m talking about the regular human kind. The ability of charismatic leaders to tell mesmerizing stories that spread fast and energize large dumb crowds to act as mass movements.

Or at least, that’s what human charisma _looks_ like. In practice, the reaction of thoughtful people to supposedly charismatic messaging is cynicism and resignation. They only listen to some self-important blowhard with an imaginary halo droning on and on, because somebody is forcing them to. Only a subset of idiot fanbois at the core of the crowd is actually enthralled by the supposedly charismatic performance. And to the extent charismatic messaging works as advertised at all, it does so by reading the core of the crowd and responding to it, creating a positive feedback loop, telling it what it wants to hear, whipping it up. So this ability to read the crowd is critical to exercising charisma.

Everybody _not_ in this feedback core is exchanging cynical jokes or shitposting about it on side channels that are much harder to monitor. So what defines human charisma is not the claim to captivating content, but three structural factors.

- One, the ability to keep captive audiences in place

- Two, creating a positive feedback loop with the small core

- And three, keeping the large cynical periphery too afraid to criticize openly

And historically, this kind of human charisma has always been a non-neutral thing. The people with the guns, able to control public spaces and distribution channels by force, had privileged access to charismatic structural modes. There’s a reason dictators mounting coups go after TV and radio stations and printing presses first. It is charisma insurance.

But end-to-end encryption as the default for communication makes it harder and harder to reserve charismatic messaging capability for yourself with guns. That’s the good takeaway from the culture wars. All charismatic messaging is created equal, so the messages are forced to fight each other in a Hobbesian war of stupid idea versus stupid idea.

The old charismatic media like large public plazas, radio, television, glitzy conferences, larger-than-life billboards, and showy parades, they don’t go away, but fewer people pay any attention to them. And it’s harder and harder to keep the attention captive. All the attention starts to sink into the end-to-end encrypted warren-like space at the edge of the network, and only the opt-in idiot core stays captive.

The cynical, anti-charismatic whispering on the margins becomes the main act, and the charismatic posturing in the center becomes a sideshow. And the whispering gets louder and bolder, and starts to drown out any charismatic messaging that does get in. Center and periphery trade places.

And with end-to-end encryption, because you can’t peek at or shape information flows without permission, even if you have large-scale centralized custody of the flows, the only way to spread or shape a message is, to a first approximation, by being a trusted part of the set of endpoints that are part of it.

Of course, more resources help you do this better — the idea of a [Sybil attack](https://en.wikipedia.org/wiki/Sybil_attack) is essentially based on gaining dominant access to a peer-to-peer network via a bunch of pseudo-identities, so basically sock-puppets. But it is much more expensive than simply having your goons take over the public square, secure the perimeter so nobody can leave, grabbing a megaphone, and boring the crowd to death while claiming charismatic reach.

In fact, the only way to exercise charisma at all will be through literal or figurative Sybil attacks. You either create a network of bot identities to dominate the end points of an information flow, or you find actual humans who are sufficiently dumb to act as your bots. And since it is becoming technically easier to detect and prevent the automated kinds of Sybil attacks, the action is shifting to human bots, essentially armies of mechanical turks.

But here there is a self-limiting effect: the value of a network drops in proportion to the percentage of bot-like idiots in it, or actual bots, so in the limiting case, your charisma can only reach mindless zombie idiots. Worse, these are the same zombie idiots you need in your core positive feedback loop, and now you have to tell them to turn around, sneak into the periphery, and act as your mindless secret agents to convert the cynics. And worst of all, you have no edge over your rivals trying to do the same thing.

That’s charisma neutrality.

And of course, in this condition, it becomes increasingly costly to control the thoughtful people, who are ultimately the ones worth controlling. The idiots are just a means to that end.

This means at some point it actually becomes easier and cheaper to simply talk to the thoughtful people rather than browbeating them with charisma. Charisma neutrality makes charisma less valuable, more equal opportunity, and more expensive. And beyond a point it starts to amplify non-charismatic thoughtful messaging over charismatic droning.

So modern networks are charisma neutral and charisma inhibiting to the extent they are end-to-end encrypted. This has huge consequences of course. Law enforcement types worry about one particular consequence, which is that the opposite of charismatic activity, namely dark, secretive underground activity, will get amplified. Particularly stuff like child abuse and terrorism.

The optimistic counter-argument is that the more thoughtful people get empowered by charisma neutrality, the harder it will be to keep such dark matters secret and secure from infiltration or whistleblowing. And remember, unlike shaping public opinion with charisma, unmasking dark activity doesn’t take dominant numbers or Sybil attacks. A single undercover law enforcement agent might be able to do enough to take down an entire network. So the dark activity networks will have to put in increasing effort to gatekeep and vet access, and maintain more internal anonymity and expensive trust mechanisms, which will limit their growth, and make them harder to get off the ground in the first place.

In other words, I’m bullish on charisma neutrality and end-to-end encryption. It’s early days yet so we are stumbling a lot on making this work well, but the benefits seem huge, and the problems seem containable.

And of course, it is important to recognize that this principle too, just like net neutrality, is not gospel. It too is just an engineering principle that will reach the end of its utility some day. Maybe it will be because of quantum computing. Maybe it will be some unforeseen consequence of the internet of things or crypto. But for now, this is the principle we need.

