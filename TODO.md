- [ ] Infrastructure housekeeping

	- [X] Update `README.md`
	- [ ] Move this list into Roam to encourage collaboration/ideas/etc.

		- Initial page: https://roamresearch.com/#/app/ArtOfGig/page/_tq-Gwlob
		- This should also include a "how to" for editing files.

	- [ ] Formally add a GitHub issue tracker, link to Roam. See [this](https://discordapp.com/channels/@me/707243573061353472/709852606096212048) and [this](https://discordapp.com/channels/@me/707243573061353472/709881527642620046).
	- [ ] Figure out a better way to share logins for Yak Collective infrastructure.
	- [X] Schedule office hours, walk interested folks through the site changes.

- [ ] Make the project page hero text `w-50-l` (or something like that), and modify the horizontal padding to keep things relatively centered

	- https://discordapp.com/channels/@me/706704472784633968/720317081660162089

- [ ] Figure out how to [make the project page header a bit thinner](https://discordapp.com/channels/692111190851059762/709753766076874774/719731952852140163), to bring decks more above the fold.

	- Reduce the font size of the left-hand sidebar?
	- Reduce padding in the header?
	- Slightly reduce the site font size?

- [ ] Schedule a more practical "how to add/update" your stuff training

	- [ ] Figure out why [non-member edits aren't working in Netlify CMS](https://discordapp.com/channels/692111190851059762/692111190851059766/720322044490678423)

	- [ ] Document Netlify CMS in Roam

	- [ ] Bring some kind of small "content moderator" team online to approve pull requests, etc.

- [ ] Migrate to [Gatsby](https://www.gatsbyjs.org/)

- [ ] Push new Yak Collective "writings" posts out as part of the GitHub post generation

	- [ ] Twitter

		- Maybe just use IFTTT for this? (If **incoming webhook** then **post to Twitter**.)

	- [ ] [Discord](https://discord.com/developers/docs/intro) (for newsletter voting/filtering)

		- https://support.discord.com/hc/en-us/articles/228383668-Intro-to-Webhooks
		- https://discord.com/developers/docs/resources/webhook

- [ ] Special menu for Yaks?

	- [ ] Migrate [onboarding document](https://docs.google.com/document/d/1I63ZKu8o0DpBG0tWhssIsCinlXeBKO-xGyvmIMXXAWE/) into website (per [Venkatesh Rao](https://discordapp.com/channels/692111190851059762/692826420191297556/709550901555363861)).

	- [ ] [Code of conduct](https://roamresearch.com/#/app/ArtOfGig/page/i92e8kE2x)
	
		- Also link this from `join.md` and `welcome.md`

	- [ ] Skill lists/graphs. (Probably should plug into Vinay's "Yak Walk Map" project!)

	- [ ] Embed the calendar of Discord chats? (Probably need to migrate to Gatsby for this...)

	- [ ] Newsletter archive

	- [ ] Newsletter sign-up (no good API right now, so probably have to direct people to Substack)

	- [ ] Join page

		- [ ] Update join page to harvest people's skills, what they want to learn. Needs an opt-in.

			- This seems to beg the question... How do we define who's a "member"?
			- [Use the join form to populate a member/skills DB](https://discordapp.com/channels/692111190851059762/704369362315772044/721454327771693106).

				- Probably needs a different back-end than Google Forms.
				- Can we use the website for this? ("Filesystem as Database"?)

- [ ] Figure out some kind of services / how to engage with us / contact us page. (How to do this while still being individual-member-centric?)

- [ ] Creating an SVG for the "yak head" logo (and then integrating it in for links, etc. where color change is important) would be potentially useful

- [ ] Integrate [Quotebacks](https://quotebacks.net/)?

	- Maybe use this for the member post pages, to make it clear that these are coming from another site?
	- Maybe automate pulling a quote (firxt `X` words) from a post, and then embedding it below the link?
		- This could get kinda busy without pagination..
	- If I do this, I wonder if people would be cool with exposing these pages directly?

- [ ] Additional member info ideas:

	- [ ] Add facility for tagging member skills
	- [ ] Add facility for [project-related badges](https://discordapp.com/channels/692111190851059762/708772535172333618/711625982473404436) on member cards and profile pages
		- Need to figure out what this will look like.
	- [ ] Personal archetype?

- [ ] Pull member tweets, like we do for RSS feeds?

	- Can we retweet things from the Yak Collective Twitter account?

- [ ] Engage with an actual designer to help with accessibility

	- [ ] Figure out how to support both light and dark OS color schemes using [`prefers-color-scheme`](https://developer.mozilla.org/en-US/docs/Web/CSS/@media/prefers-color-scheme)

		- This is a lot more complicated than you'd think, what with header images, accent colors, etc.
		- We probably need help from someone who, you know, actually has some web design experience.

- [ ] Rotating slogans

	- https://discordapp.com/channels/692111190851059762/712112363566006322/719654392327962643 (etc.)
	- JavaScript (per page load)? Or randomized includes (per build)?
		- Kinda inclined to go with randomized builds, as I so strongly dislike JavaScript.

- [ ] Figure out how to integrate feed list into the Netlify function, rather than using IFTTT

	- Ideally, this should somehow pull data from member collection...

- [ ] Revisit use of Google Analytics on the site (some folks on Discord have expressed GDPR worries)
