- [X] Initial Netlify migration

	- [X] Add `CHANGELOG.md`
	- [X] Add `.gitignore`
	- [X] Add `Gemfile`
	- [X] Migrate to Netlify-style redirects
	- [X] Migrate to Netlify-style build infrastructure
	- [X] Separate member data from page
	- [X] Clean up unused files
	- [X] Add as many (populated) RSS feeds as I can find
	- [X] Add member RSS feeds to header
	- [X] Create list of writings (from RSS feeds)
	- [X] Rename `members.md` to `members.html` to match content
	- [X] Add RSS and JSON feeds for writings category
	- [X] Create reusable "member card" widget
	- [X] Fix missing footer on homepage
	- [X] Update `README.md` to reflect changes
	- [X] Remove webhook reference (denial of service risk)

- [X] Integrate this repo into the main site

	- [X] Get current site into Netlify
	- [X] Swap DNS over to Netlify
	- [X] Reach out to members and make sure that RSS feeds are correct
	- [X] Merge this repo into current site

- [X] Redesign projects page

	- [X] Greenlit projects with tentative launch dates, stub "comming soon" pages
	- [X] Figure out how to lightly theme each project so that it has more of its own identity

- [X] Finish regularizing formatting, cleaning up unnecessary files/classes/divs, etc.

- [X] More fully document what different includes and data files do

- [X] Move `members.yml` data structure into member _pages_ listing projects they've participated in and recent posts

	- Member lookup will need to be indirect, through `site.categories["members"] | where: "id", "/members/venkatesh-rao"`, etc.
	- How to handle the creation of `yak-planet.ini`????
	- All member names should be links pointing to this page.
		- Should this apply to the member page itself?
		- How should the member page be linked back to?

- [X] Move to a more warren-like structure?

	- No navigation, more in-page links
	- ~~Heavy use of tagging for projects?~~
	- ~~Can we figure out how to auto-tag incoming posts from feeds? Maybe some sort of light keyword-based classification? (This is another argument for moving to Gatsby, as this will probably be easier to implement there.)~~
	- Create links between members and all of their posts/projects.
	- Use member and home pages as hubs/entrances.

- [ ] Figure out how to make site friendly for non-technical updates (this almost certainly means migrating to another platform)

	- ~~Migrate to Hugo and use a data file directory stored in Dropbox or Google Drive? Probably simplest, but least flexible long-run.~~
	- Spin up NetlifyCMS? Might not actually meet this need.
		- I increasingly like this idea, especially if `members.yml` can be broken into individual pages.
		- Will require people to have a GitHub account... (Bug? Feature?)
		- I think we'll want to use an "editorial approval" workflow, just to make sure that bad changes don't get pushed to the live site.
	- ~~Migrate to Gatsby and push user-editable files into Google Drive or Dropbox? Not clear how to do this within a dev/prod setup. (But maybe we don't care?)~~

- [ ] Figure out a way to archive incoming news posts (right now, if a post disappears from a member's feed, it will disappear from the site during the next rebuild)

	- Can we check `yak-planet.db`, `yak-planet.ini`, and `writings/_posts/*` into GitHub as part of the build, using a token for authentication?

- [ ] Infrastructure housekeeping

	- [ ] Add facility for tagging member skills
	- [ ] Update `README.md`
	- [ ] Move this list into Roam to encourage collaboration/ideas/etc.

		- This should also include a "how to" for editing files.

	- [ ] Formally add a GitHub issue tracker, link to Roam. See [this](https://discordapp.com/channels/@me/707243573061353472/709852606096212048) and [this](https://discordapp.com/channels/@me/707243573061353472/709881527642620046).
	- [ ] Schedule office hours, walk interested folks through the site changes.

- [ ] Migrate [onboarding document](https://docs.google.com/document/d/1I63ZKu8o0DpBG0tWhssIsCinlXeBKO-xGyvmIMXXAWE/) into website (per [Venkatesh Rao](https://discordapp.com/channels/692111190851059762/692826420191297556/709550901555363861)).

- [ ] Figure out some kind of services / how to engage with us / contact us page. (How to do this while still being individual-member-centric?)

- [ ] Figure out how to integrate the Yak Collective Twitter list? (Again, probably easiest in Gatsby.)

- [ ] Add facility for [project-related badges](https://discordapp.com/channels/692111190851059762/708772535172333618/711625982473404436) on member cards and profile pages

	- Need to figure out what this will look like.

- [ ] Figure out how to automate some sort of mailing list

	- Bootstrap off of existing feed page
	- Pull notes from Roam (how? which ones?)
	- Push to Substack (how?) or Mailchimp (Mandrill API?)
	- Minimal/no human curration
	- [Reference idea](https://discordapp.com/channels/692111190851059762/692847835766325386/708707475117047910) (Nathan Acks/Darren Kong)

- [ ] Figure out how to page projects and member posts. [Jekyll doesn't support this robustly](https://jekyllrb.com/docs/pagination/), but Hugo, Gatsby, and other generators do

- [ ] Revisit use of Google Analytics on the site (some folks on Discord have expressed GDPR worries)
