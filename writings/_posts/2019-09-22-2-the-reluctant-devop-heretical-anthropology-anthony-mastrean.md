---
layout: post-external
title: "#2 — The Reluctant Devop: Heretical Anthropology (Anthony Mastrean)"
date: 2019-09-22 00:49:28.000000000 Z
author: 100080
original_link: https://hiredthought.com/2019/09/22/2-the-reluctant-devop-heretical-anthropology/
---

Ben kicks off episode 2 with Anthony Mastrean, a friend, colleague, and professional organizational agitator. They discuss the origin story leading to their work together, what it’s like changing an organization from the inside, and the underrated discipline of Software Configuration Management.

- [Steven Shorrock: The Varieties of Human Work](https://humanisticsystems.com/2016/12/05/the-varieties-of-human-work/)
- [Tasshin Fogleman: Burja Mapping](https://tasshin.com/blog/series/burja-mapping/)
- [Discussion with Jabe Bloom and Sue Borchardt](https://vimeo.com/360821729)

Follow Anthony on Twitter:

> Please define "minor breaking change"
> 
> — Anthony ![🤞](https://s.w.org/images/core/emoji/12.0.0-1/72x72/1f91e.png) (@AnthonyMastrean) [June 13, 2019](https://twitter.com/AnthonyMastrean/status/1139258175213973508?ref_src=twsrc#5Etfw)

Music by DJ Quads  
[https://soundcloud.com/djquads](https://soundcloud.com/djquads)

## Transcript

**Ben** [00:00:00] Hello everybody and welcome to episode 2 of the Hired Thought podcast. I am very happy to be joined today by Anthony Mastrean. He and I go way back. We worked together at an old organization. He taught me a lot of things, and I like to think that we have a lot of interesting stories to tell. Anthony tell us a little bit about yourself. Where are you right now in this wonderful world.?

**Anthony** [00:00:23] Hey Ben, I’m actually working from home these days which is… man, it’s really screwing me up for future employment. I don’t know if I can go back to somebody else’s office in any capacity.

**Ben** [00:00:39] Do you have a kid in each arm while you’re working every morning, is that how it works?

**Anthony** [00:00:41] Yeah well that’s a big part of it. I’ve got two little ones, so occasionally they’re my pair programmers or office partners, if you want to call them that.

**Ben** [00:00:51] Family mob programming I guess.

**Anthony** [00:00:53] Right. Yeah. So maybe in a couple of years when they’re in public school for most the day, that might change things, but…

**Ben** [00:00:58] So you’re working from home. We met when we were working at McKesson. We were working on pharmacy systems and doing kind of like lots of interesting stuff there. I guess let’s talk through the origin story just a little bit. I think I first met you at devopsdays Pittsburgh 2014.

**Anthony** [00:01:22] Yeah there was a… I think of that as the year of serendipity. There was a lot of meetings and and happenings and like intellectual things occurring for myself, I don’t know, maybe for Pittsburgh? It’s hard to claim anything for an entire region. But there was definitely some stuff starting that year.

**Ben** [00:01:40] Yeah, let’s claim it for Pittsburgh. Let’s claim it for you, too. So tell me a little bit about that though. What was going on that year for you?

**Anthony** [00:01:49] [00:01:49]I think the way I like to describe it to I don’t I don’t know whether to be cheeky or introspective. I think I became like a reluctant devop or something like that. [11.8s]

**Ben** [00:02:02] [00:02:02]The lone reluctant devop. [1.0s]

**Anthony** [00:02:05] [00:02:05]Was it reluctant, or is it… I don’t know. Anyway, I had had enough of just normal application development, which is funny, ’cause that’s where… that’s the meat of this industry. So many developers developing right. Yet there’s so much more work to be done. And I think I either accidentally or kind of subconsciously found myself constantly drawn to that other stuff. The things that happened, not just before you start jamming on the keyboard, you know what’s up with work planning, you know? Or organization of teams? Or is this a JIRA ticket? Like what kind of system are we using? Right but like even after all that, right OK, we’ve got this code? Where’s it going? Is there a build?. Are there tests? Should you test first? Is the build passing? Has it been red for four months, like you know all these things. What about deployment. Who’s deploying this? And where and how are those environments managed? You know even down a little bit, like where am I committing this code to? Who’s server is running source control? It’s actually a desktop under someone’s desk… There’s all of these questions I think that surround development that…  I think a lot of people make a lot of it, like “well,  you know, developers ought to understand all that.” I think that’s like the Twitter version of the job, right. Sure. All you, you know, blue checkmark people on Twitter saying that developers should know all this. That’s different than the thousands of people we’ve all worked with who don’t work like that. So there’s this massive gap. [105.1s]

**Ben** [00:03:52] [00:03:52]You can point at all sorts of stuff, like how do people learn? How is it that you are supposed to have come by those skills, by that knowledge? And the reality is, I think in a lot of especially enterprise organizations, and perhaps enterprise organizations in Pittsburgh, in particular… Maybe I’m being a little bit too broad sweeping here, but I think there is a tendency to create bubbles and stay within them. And if you are doing any migrating it’s maybe between bubbles every couple of years, and they’re all such small bubbles that they’re missing the larger picture of the larger changes in practice. What do you think is at the center of that? Is it just we’re not learning when we should be learning? Or if we should know that stuff and all the blue checkmark people are telling us that, like OK, but how? And why? And when? [56.5s]

**Anthony** [00:04:48] [00:04:48]I guess it’s interesting maybe to use Pittsburgh as a foil. I don’t think we have any Thiel organizations right here in Pittsburgh, if you want to think of the wackiest organizations that are out there somewhere. So what we’ve got going on is very traditional right. Like, well, we need project management, so we’ve got a project management office. Well those developers just need to be developing, wo we’ve got the test group, and they’re probably offshore still. It’s 2019, and we still have offshore test groups. Or, well, the developers need to develop, so we need to have… well who’s going to put all that software together? Well let’s have a configuration management group, right, and let’s have a build release team. Certainly we have operators, right, and they’ve got their own V.P. of operations, like there is no direct line between developers and operations so… I hesitate to say these things just exist because they exist right. I don’t want to give a tautalogical answer but, man, these things just seem to exist. I don’t know… I don’t think we have enough… we need to bring the anthropologists in, and say, “Why, why did we do this? Tell us, because we can’t see it. We’re too close to it to to understand why they exist let alone how to change it, in some cases. These are the systems of rewards and incentives and, I mean how about just job descriptions?[78.3s]

**Ben** [00:06:08] [00:06:08]Oh don’t even get me started [0.0s]

**Anthony** [00:06:09] [00:06:09]I’m sure I’ve encountered plenty of these team members, right. You know, the developer, the CM guy, the whatever, who… maybe they even want to grow beyond what they’re doing now, but, boy, it’s not in the performance review system. So, “I’m not going to cross that line.” It’s too scary in a way. There’s too much risk in doing that. [20.1s]

**Ben** [00:06:30] You have to take on a lot of risk as an individual to attempt to be… essentially an anomaly, right? If the rest of the organization is aiming for uniformity… [00:06:42]It’s interesting that you mention job descriptions, because my whole thing with that is… tell me how you are going to describe exactly the kind of person that you want to bring in, as if it’s a part that you can go down to a shop and… “I need part CL-732, and I need it in this configuration and as part of this warranty package.” All that kind of stuff as if it’s a fungible thing you just plug in. [22.8s]

**Anthony** [00:07:05] [00:07:05]Yeah. Like, how dare you describe a complex job with very simple statements in a job description. Right? [7.5s]

**Ben** [00:07:15] [00:07:15]When I was looking for work, and really before we started working together, and even after and later stages in my career, I was just looking at job descriptions. And the problem for me was constantly trying to project a version of myself that might fit into some of these boxes, and I just found that to be an impossible kind of idea. Because one, they’re not describing it, remotely. Like phenomenologically they are not describing the thing. They are describing an idealized version of the thing, which is not even… that doesn’t exist. [34.6s]

**Anthony** [00:07:51] [00:07:51]I’m always going to get this wrong, but there’s a fellow out there, Steven Shorrock. I don’t know if it’s his idea or not, but he often comes back to this concept that there are overlapping and non overlapping things, like work as design, work as described, work as understood. And these things very rarely and in very small parts ever overlap. So you have the job description, it’s like wow, it’s… And who the hell wrote this thing too, right? That probably has a big effect as well. Is it what we want the job to be? Is it what the job is? Is it what I think the job is? Like there’s so many… Or is it what I think will get candidates in for the job? Like it’s just such nonsense. [43.4s]

**Ben** [00:08:35] It’s so multi-dimensional, and I think this shows up everywhere, right? I guess the kind of joke here is at one point I was helping write job descriptions. When I worked with the state of PA, we needed to hire sysadmins, and I won’t say that that was my responsibility, but I was certainly contributing to that.

**Anthony** [00:08:54] Like, “I can do this better,” right? “I can help make this improvement.” And maybe you do, within an axis. Like, within whatever version of the job description that you thought the job description should be. Maybe you did make it better but…

**Ben** [00:09:07] That’s our pathology I think, is we show up and go, “OK. The system seems to be… like, it’s working, clearly, but it’s also causing a lot of pain.” Like there are a lot of bones being ground up in the middle of it.

**Anthony** [00:09:18] Yeah, so I think it was… lots of accidents, right? Like I started my career at FedEx. And talk about all the syndromes that any organization could have, it was there. There’s pigeonholed development, offshore testing, a CM team. A team that was responsible for “the builds,” the golden images and such. And towards the end of my run there, it was so… I didn’t even know whether to call it dysfunctional or not because actually we made it functional by… At some point someone sent the CM team a script to build the software, because the CM team didn’t even write the scripts, right. They just ran the scripts to build the software. And at some point the script we gave them just printed, “success.” And then a senior architect went off and actually did the build and release separately. So again, dysfunctional or functional? I don’t even know how to describe… So there was some formative stuff going on there, at least. Here’s how some big organizations can operate. I won’t say that was all of them, but it sure did… it looked like a thing.

**Ben** [00:10:28] Well I mean we like our process. We like having little boxes to check off as we go along. But I think the thing that I learned while working with you a bit, and really the lesson that’s been reinforced over and over again as I’ve been finding my way into larger organizations working in a consulting and support capacity… I just see how much all this stuff is just made up. We are constructing reality around us to the extent that someone else has to construct an interface to that reality. Like the script example you just gave, “Oh this person will be nervous if they don’t have this part of their process to check off.”

**Anthony** [00:11:14] Or they might not have a job, which I mean, understandable, but like, is that a good reason? I think at McKesson it was interesting. [00:11:24]So I came in, the team was called Software Configuration Management. Like what is that? That terminology is really old, except maybe… it might only be old to the coasts, right? Like a lot of businesses in the middle of the country still have a thing called SCM. And I actually think it’s still a discipline. I think there are topic areas and there are knowledge areas there, and there are patterns and practices, and I hesitate to maybe even say best practices for Software Configuration Management. And oh man, I’m about to be like so, what is the word, well, I’m going to be cheesy. Like, this job shouldn’t exist, right? So I joined this weird place. Not a developer. Which actually I’m happy, because the software system we were working on, this 15-year-old Java Swing application, boy… I really don’t want to jump into that. But I could jump in on the edge of that, in the SCM team. So here, run the Subversion server. Babysit the builds. Handle the build and release process. So now I was that guy that I was previously handing empty scripts to. But could we effect change? Could we come in, and again, cheesy as it may sound, this job doesn’t need to exist. Developers are already doing this work right, or they’re so close to it. You know, and to hint at the Wardley side of things, why can’t we commoditize these things. Like, you’re branching strategy ought not to be creative. Your build system should not be bespoke, in most cases for line of business apps. Like literally, why does this job exist? Let’s buy a couple of cloud services, whether that’s some Bitbucket stuff, some GitLab stuff, some JIRA stuff. Just buy something. Buy something, follow a “best practice” Follow a decent practice that’s probably way better than what you’re doing now, maybe not the best, but the job doesn’t need to exist. But you know what job that does need to exist? The Agitator that gets everybody to change to the commodity thing. [121.7s]

**Ben** [00:13:26] Yeah I think that’s the key part of this. It’s the transition between… I think all these systems that we build tend to try to maintain what already is working and what already exists… The Known. And it’s working, so we should just keep doing it, right?

**Anthony** [00:13:41] Right, it’s working but it’s leaving… Look at the damage it’s leaving in its wake. And I don’t think, me 10 years ago, I wouldn’t have been talking like this. I think maybe I was on the same path technically, but I was less focused on the people side. I didn’t see it, maybe because 10 years ago I had boundless energy and whatnot. But like nowadays it’s like, man, we’re just killing people. These jobs are killing people! You know we could do so much better and unleash their capacity. And emotional capacity, too. Not just like, “Boy, we can get more stories done.” “Boy, we can make people feel more valuable.” And if that valuability adds value to the company let’s go for it. I think those two things are intertwined.

**Ben** [00:14:27] The change that has occurred over… there’s kind of a leapfrog moment, right, where you have the option to… If you’re not going to stay incrementally in step with the change that is going on around you, the evolution if you will, of things that are practices, patterns, the technology, all that kind of stuff. If you’re not going to stay in step with that, or even anticipate it, if you’re not gonna do that, you’re gonna fall behind. So I don’t know exactly how to describe this kind of transition should happen in general, but I think it’s useful to have a momentary transitionary role, where you go from… I mean what was the state of SCM before, before there was a centralized…

**Anthony** [00:15:16] Tickets were open for three years. Builds were red for four weeks at a time.

**Ben** [00:15:21] Yeah.

**Anthony** [00:15:22] It’s funny a lot of it’s technical stuff, right. As a new person into this organization, which I think is desperately what this organization needed. The new guy at this organization had been there for nine years. And I apol- I know I’m saying guy a lot. But like literally, that’s just who they were. But nine years, there’s no way you’re going to come in… you’re already taken away, you’re floating with the system at that point. So to be dropped in and to see that, to be able to see, “Oh that build has literally been red for 4 weeks. This ticket in my backlog now has been open for three years. Close it or fix it or something!” But that’s easy for me to say, because I’m not here with all the organizational, emotional baggage of it how it needs to close that. I think maybe that’s important too. [00:16:15]This journey it’s not just technical. These people were shipping successful software, you know maybe not as fast as they could, which we found out later. We were able to ship much faster. So they were useful, technical, savvy individuals. So I think the problem was probably not like, “Oh we just needed someone to come in and figure Puppet out. Do this migration from SVN to GitLab or whatever.” A lot of people could do that. But a lot of the work was, “How do we bring these people along with us?” They’re scared. Like literally people were scared. “I don’t think we can do it this way. I’m nervous about that, either because we’re gonna lose work, or we’re going to break something, or it’s just going to hurt. What if we mess up? And then I’ve got to go backwards, or I have to learn something new. I’m so comfortable with the way we’re doing it now.” [53.2s]

**Ben** [00:17:10] The performance improvement situation as well. You are evaluated based on commitments that you made three quarters ago.

**Anthony** [00:17:17] A year ago.

**Ben** [00:17:19] What is… How!? You actually cannot change, unless you adopt a mentality and have the support structure that is able to look at that and go, “Yeah, well duh. This should have changed.” I think in some ways we had some luck there where some people were a little bit more willing to go along with the malleability of that.

**Anthony** [00:17:40] I believe our team was vacant for something like six to nine months. The previous folks had… I think it was a year that the last proper SCM person had quit. Someone had stepped in part time to manage things. So obviously that wasn’t going to be a huge change. And then it was literally vacant. So there was no CM. And again, well so CM shouldn’t exist, but in this context it desperately needed to exist. So yeah, we came in, and I think we came into a total… I don’t know how to recreate this or even if I should… But we had a new manager, a new director, a new VP, the president changed. This whole business unit down to our stupid little seats in the cube farm changed in weeks. So our performance review was not the same one that was happening to these folks who’d been there for 15 years. There’s lots and lots of things right.

**Ben** [00:18:39] Yeah I mean that was wild, because on the one hand we could literally shape the way that we could do the work, the way that we thought that it should be done.

**Anthony** [00:18:52] Yeah it was easy to come in and say, “This is not how CM works” even though I didn’t know that. Like I wasn’t sure. It was my first CM job. Like what even is CM right? That’s what I’ve been trying to say. Really accidentally joined the team this way in a position I’ve never formerly held. Is CM even taught? There’s like one book that I know of.

**Ben** [00:19:12] I remember you like going into all these places on the Internet, just trying to dig and dig and dig… like, “What is branching even?”  Not just asking what branching strategy should we use, like what’s popular. It was more like, “What is this even?”

**Anthony** [00:19:27] Like what even yeah… This is the craziest thing about software development. And I guess a lot of people say, “Oh but it’s a young discipline.” But we don’t actually know for sure, evidence-wise. We don’t know that source control is good. Like prove… I know that it’s good, I feel good when I’m using it, but we don’t have anything like… There’s no study, there’s no pedagogy, there’s not like… all of these hundred dollar words. Like we don’t know why what we do should be done… what to do, why we should do it, how we should do it, we really don’t. We have a lot of stories right now. Maybe that’s how every industry like this starts. We don’t have 5000 years of history programming computers, but maybe someday we will.

**Ben** [00:20:16] I get really excited when I see some case studies about something.

**Anthony** [00:20:21] Yeah oh, we only have stories, but at least let’s bring 10 of them together in one paper. Can I make sense of any of this?

**Ben** [00:20:28] Somebody trying to do some analysis to figure out what makes sense here, what makes there. It’s largely expert based. You have people who we look to as the gods of the industry, if you will.

**Anthony** [00:20:41] Yeah. That’s problematic.

**Ben** [00:20:45] That’s the way, it’s the blue checkmark people. Here they are. Here’s the answer. And they’re largely giving experiential anecdotal evidence, and I’m just thinking of…

**Anthony** [00:20:56] And from a very unique perspective.

**Ben** [00:20:58] Yeah totally!

**Anthony** [00:20:58] Right, that’s the thing. Like the blue checkmark consultant, agile consultant, or whatever, devops… Like these people are already in a totally different context than the 30 of us that have been sitting on this team for the last three years just trying to do whatever it is we’re doing. There’s no… I like what the folks are doing with the State of DevOps report. And of course we’re going to go there, right. Like how you’ve got PhDs and scientists and statisticians. You know you’ve got serious people doing serious work on this industry that is sorely lacking anything that’s serious. But I struggle with that, like a lot of this stuff comes out which is just like “Just do Trunk Based Development.” OK.

**Ben** [00:21:45] “Just.”

**Anthony** [00:21:45] And then what. Or how do I even… Like, what do you mean, “just do Trunk Based Development?” We literally, I think we had… something on the order of 60 branches when we got there. And it was like, major, minor, patch, and hotfix. And I think we ran the numbers once, and we had like an average of 17 hot fixes. We contractually promised a major, two minors, and like three patch versions. If you did the math on that, we were supporting forty five versions of the software at once. We were doing it through, or you know the team, you know the “we” that was there at the time, we were doing it through whatever branching strategy we could figure out. You can’t just like… these people on Twitter and there 120 characters at the time. “Just do Trunk Based Development. Good luck.” “Thanks a lot. You’re an asshole.” Like you can’t do anything with that. You know?

**Ben** [00:22:50] I think that’s it.

**Anthony** [00:22:51] It’s so frustrating.

**Ben** [00:22:52] It’s always advice, right. I get that in order to move things forward, you have to work at the edge, in the sense that you have to point at something that is… If you’re starting from nothing, you could probably consider starting here. That seems reasonable.

**Anthony** [00:23:08] Right. Definitely. If you were starting with nothing, right. That’s great. And I think there’s even like, there’s stuff out there, man. I’m just constantly impressed by GitLab. Like just go get GitLab. Like, just buy it. The entire thing they’ve got this whole… I know this is not an advertisement for GitLab but the concept like…

**Ben** [00:23:27] If they want to sponsor…

**Anthony** [00:23:27] There’s a team who’s producing tooling for you, and they’re saying, “We want to take care of the entire process, the entire lifecycle of software from planning to designing to developing to capturing issues to doing ops. We’re gonna give you a tool kit. Now, it has opinions. It works in a certain situation. Some of those tools are different maturity levels.” But the fact that they even published a maturity chart for each of their features \*mind explosion noise\* is really great.

**Ben** [00:23:54] I think that’s really important to have that kind of structure in place, because the defaults that you get are… if they’re not perfect, that’s fine. But they’re at least sensible and principled probably.

**Anthony** [00:24:05] And they’re at least not 15 years of custom scripts tying together custom processes. At least you’re moving from something structured. Hopefully to something else structured but that is a better choice for whatever your context is. And that’s again why it’s so frustrating to get this advice. Or another one that I love is like, “Just do feature flags.” So how do I move to Trunk Based Development when I’ve got release-per-branch, I’ve got 45 releases that I’m contractually obligated to maintain, I can’t… I’m a CM guy. I can’t make this corporation decide to contract their software differently. Right. We eventually did, but only because we had that whole management chain entwined in this. “Hey how can we actually produce software faster.” “Well stop promising that we’re going to support forty five versions.” That idea came from us, but it was enacted by them, they talked to legal and sales and everything. So that is doable, but on a much longer timescale. So okay how do I get to Trunk Based Development now that that’s my, okay great, that’s my holy grail. How do I get there? “Well just do feature flags.” Well that’s not like…. Have you ever done feature flags? It doesn’t mean one thing. It’s complicated at best. You just gotta turn stuff on and off? Well feature flags means you’ve got to really have your configuration sorted out, and that configuration now has to be exposed. Is that feature flags to the user, to an admin, to an operator? Who gets the feature flag? Where do they toggle it? How are you toggling? You really gotta have your dependency injection sorted out. What the hell is dependency injection? You have to unwind all of the job. You know, but just use feature flags dot com. So frustrating, this entire job.

**Ben** [00:25:50] There’s there’s so much work to be done to help people adopt practices from a standpoint of… you’re starting with what already exists. And actually finding a path from that, do something sensible that’s… not even just sensible, because it all makes sense, right. Even the legacy, if you will, makes sense.

**Anthony** [00:26:11] Right, like, it can’t be irrational if it got done by human beings and it was sold. You know what I mean, and I think a lot of people like to throw that around like, “Oh we’re not rational hahaha. Like randomness, you know.” No no. I think what rational means is that you’re reasoning. We are always reasoning, whether or not we’re coming up with the right answer or the best answer or whatever. But I think everybody was reasoning all along, right. These 15 years, that transition from startup, to corporation, I think the team was bought and sold three or four times. [00:26:49]Everybody’s reasoning. Throughout all the different performance management programs, all the different changes in methodology, they’re reasoning all along the way. So I think we gotta be careful with that, that we’re not just harming people while we’re trying to unharm people. Like, “You idiots did that.” No, it’s like “We did this thing, obviously. But maybe we can do a little bit of a different thing.” [26.1s]

**Ben** [00:27:18] This is probably a weird place to go with this but the thing that I heard Jabe (@cyetain) say recently… We had a really interesting conversation with Sue Borchardt (@contemplatethis) about… It was focused on on some things that Jabe was tweeting about, but one of the things he mentioned was like Janus time. The god of transition, the two faces. When you’re changing, you are literally in both the future state and the previous past state at the same time, and you’re trying to reconcile both of those things together. Just hearing that was like, “Ohhhh, right. That’s why it’s so hard.” Because we have to be of two minds at once. I don’t know about you, but I have a hard time being of one mind at any one given point in time, let alone…

**Anthony** [00:28:08] Right. Right. And in part, you’re also, like we talked about earlier, you’re in the mind of the thing that you’re trying to change, too. The thing was brought together by how many people… We call it the organization, because it’s hard to… Sometimes it’s hard to literally know. I don’t know who to blame for this, to go ask them, “What were you thinking and why? And what were all the forces on you?” No, at some point we just have a shortcut. The organization made this, maybe you understand what was going on in the organization at the time. So now you’re of two minds, you’re reflecting on the other minds, right. Ah man!

**Ben** [00:28:47] Most often the answer is, nobody knows. It’s all in someone’s head, and the only way that would ever make its way out is if you asked them specifically about it. And to even know who to ask is of course a question. If you’re just doing inquiry, you’re just trying to find out what happened, what brought us to this point, so you can figure out how to go from there, how to move on, how to move forward. You almost have to do an archeological dig into the artifacts, into the org charts, into the email threads, just to figure out who was there.

**Anthony** [00:29:58] Right, these artifacts and these behaviors that other people are having around these artifacts, implicit or explicit, they’re shaping the next person who comes in, and the next person that comes in, or the next decision that’s made. How did you get away doing this for 15 years? It’s because the first person did it and never questioned it? Or it wasn’t hard enough, or it wasn’t within their… That’s what I wonder, too, like how many people… What was special about you and I, that we came in and got rubbed the wrong way by something that had been going on for 15 years. So was it bad if 15 years’ worth of people lived with it for that long? How did we know to change it? Why now? To what? Let’s go, I’m on my TOC (Theory of Constraints) right now. Like why did we change this, and why did we change it to what we changed it to? And what was missing that nobody was changing it before? Or maybe we didn’t notice that they were crashing against the rocks of the organizational inertia, I don’t know.

**Ben** [00:31:06] I mean there is a notion of agitation here though, too. So you know about Tasshin. And Tasshin is a Buddhist monk. He’s really into the Theory of Constraints, all this kind of stuff. But one of the things he talks about is this thing called Burja Mapping, and Burja Mapping is a way to think about power dynamics in organizations, and really how to… It’s a way to think and model a system of social dynamics and power dynamics. But one of the aspects that he talks about is the difference between live and dead players. Dead players are basically following a script, and sometimes that’s very good to be doing, whereas live players are often breaking scripts and writing their own. And that is also great for certain circumstances, and all this kind of stuff. And it’s not like a binary thing. I think it’s probably more of a gradient kind of dynamic. But when you talk about, like, “What is it that’s keeping the things going?” is that you have a lot of people following scripts, and then there’s the agitator, the heretic. I think that’s kind of the role that you played… Maybe what happened was that there was a pocket of progressively more heretical individuals in this organization. And what that enabled was, those people bringing in other people that were even more heretical.

**Anthony** [00:32:32] It was kind of by chance then, even.

**Ben** [00:32:35] Well yeah. I mean everything is by chance, maybe.

**Anthony** [00:32:38] That’s probably true, right?

**Ben** [00:32:39] But at the same time, you were particularly… I’m gonna use the word “agitating,” but I mean it in a good way. You’re looking at this system and going, “What!? Like, what are you doing? This doesn’t make any sense. Why would you do that to that person?” All that kind of stuff didn’t make sense to you.

**Anthony** [00:32:59] And that’s what it comes down to it’s not… And I think this is hard for even the best operator… It’s not, “This is bad, morally.” Like, you’re doing something… Although maybe that is sometimes the first inclination. Maybe it’s more phrased like, “This is wrong technically.” But how do I know that, right. “Well because you’re hurting people.” But like you talked about in the episode I listened to, the process that occurred at the end of a release that someone had to take home on their laptop right and fight all weekend… How can you do this to people? How can you let this person perform this process at the end of the release for years and years on end? Chewing up weekends when it was an rsync. That’s what’s so frustrating. It’s not even new stuff right. It wasn’t new technology. It wasn’t some creative endeavor. Like if anybody took a minute to write it down, they would have been like, “What are we? We’re asking who to do what? How many times? When?” I think it would’ve been so obvious. But it’s hard to go back and think about it like that.

**Ben** [00:34:08] Anthony, thank you so much for coming on and talking to me. I really appreciate your time, and I’m so glad that we got to talk a little bit about software and systems and humans and all this wonderful stuff. How can people find out more about you? How can people ask you questions and things?

**Anthony** [00:34:26] Don’t, hahaha. I’m @AnthonyMastrean, and I’m sure Ben will put the link somewhere. That’s probably the best way to get to me right now. I have a bad web site that’s got garbage on it. I’m constantly hoping to update those materials, right…

**Ben** [00:34:44] It’s almost like it’s kind of a metaphor for software.

**Anthony** [00:34:48] It really is, right. That’s not gonna do it.

**Ben** [00:34:52] All right, thanks man. I’ll put a link to all the things in the show notes.

**Anthony** [00:34:57] Cool
