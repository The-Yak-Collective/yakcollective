Based upon to-do list from Nathan Acks' "v2" development work + discussion on Discord on May 5, 2020. Ordered in rough priority (though some things are easier than others, and thus might get done sooner)...

- [ ] Integrate this repo into the main site

	- [X] Get current site into Netlify
	- [ ] Swap DNS over to Netlify
	- [X] Reach out to members and make sure that RSS feeds are correct
	- [X] Merge this repo into current site

- [ ] Redesign projects page

	- [ ] Greenlit projects with tentative launch dates, stub "comming soon" pages
	- [ ] Figure out how to lightly theme each project so that it has more of its own identity

- [X] Finish regularizing formatting, cleaning up unnecessary files/classes/divs, etc.

- [X] More fully document what different includes and data files do

- [ ] Figure out how to make site friendly for non-technical updates (this almost certainly means migrating to another platform)

	- Migrate to Hugo and use a data file directory stored in Dropbox or Google Drive? Probably simplest, but least flexible long-run.
	- Spin up NetlifyCMS? Might not actually meat this need.
	- Migrate to Gatsby and push user-editable files into Google Drive or Dropbox? Not clear how to do this within a dev/prod setup. (But maybe we don't care?)

- [ ] Move this list into Roam to encourage collaboration/ideas/etc.

- [ ] Migrate [onboarding document](https://docs.google.com/document/d/1I63ZKu8o0DpBG0tWhssIsCinlXeBKO-xGyvmIMXXAWE/) into website (per [Venkatesh Rao](https://discordapp.com/channels/692111190851059762/692826420191297556/709550901555363861)).

- [ ] Figure out some kind of services / how to engage with us / contact us page. (How to do this while still being individual-member-centric?)

- [ ] Move to a more warren-like structure?

	- No navigation, more in-page links
	- Heavy use of tagging for projects?
	- Can we figure out how to auto-tag incoming posts from feeds? Maybe some sort of light keyword-based classification? (This is another argument for moving to Gatsby, as this will probably be easier to implement there.)
	- Create links between members and all of their posts/projects.
	- Use member and home pages as hubs/entrances.
	- Members should be "mini-hubs", linking to their posts and the projects they've participated in. Unclear if this should be done in stand-alone pages, or in "fly-outs" on the members page.

- [ ] Figure out how to automate some sort of mailing list

	- Bootstrap off of existing feed page
	- Pull notes from Roam (how? which ones?)
	- Push to Substack (how?) or Mailchimp (Mandrill API?)
	- Minimal/no human curration
	- [Reference idea](https://discordapp.com/channels/692111190851059762/692847835766325386/708707475117047910) (Nathan Acks/Darren Kong)

- [ ] Figure out how to integrate the Yak Collective Twitter list? (Again, probably easiest in Gatsby.)

- [ ] Figure out how to page projects and member posts. [Jekyll doesn't support this robustly](https://jekyllrb.com/docs/pagination/), but Hugo, Gatsby, and other generators do

- [ ] Figure out a way to archive incoming news posts (right now, if a post disappears from a member's feed, it will disappear from the site during the next rebuild)

- [ ] Revisit use of Google Analytics on the site (some folks on Discord have expressed GDPR worries)
