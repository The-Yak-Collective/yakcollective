Based upon to-do list from Nathan Acks' "v2" development work + discussion on Discord on May 5, 2020. Ordered in rough priority (though some things are easier than others, and thus might get done sooner)...

- [ ] Integrate this repo into the main site

	- [ ] Get current site into Netlify
	- [ ] Swap DNS over to Netlify
	- [ ] Reach out to members and make sure that RSS feeds are correct
	- [ ] Merge this repo into current site

- [ ] Finish regularizing formatting, cleaning up unnecessary files/classes/divs, etc.

- [ ] More fully document what different includes and data files do

- [ ] Make current site repo private? (This will help keep projects from being exposed prematurely.)

- [ ] Set up development site

	- [ ] Create a `develop` branch for further changes
	- [ ] Create a new site building in Netlify corresponding to the `develop` branch

- [ ] Figure out how to make site friendly for non-technical updates (this almost certainly means migrating to another platform)

	- Migrate to Hugo and use a data file directory stored in Dropbox or Google Drive? Probably simplest, but least flexible long-run.
	- Spin up NetlifyCMS? Might not actually meat this need.
	- Migrate to Gatsby and push user-editable files into Google Drive or Dropbox? Not clear how to do this within a dev/prod setup. (But maybe we don't care?)

- [ ] Figure out how to page projects and member posts. [Jekyll doesn't support this robustly](https://jekyllrb.com/docs/pagination/), but Hugo, Gatsby, and other generators do

- [ ] Move to a more warren-like structure?

	- No navigation, more in-page links
	- Heavy use of tagging for projects?
	- Can we figure out how to auto-tag incoming posts from feeds? Maybe some sort of light keyword-based classification? (This is another argument for moving to Gatsby, as this will probably be easier to implement there.)
	- Create links between members and all of their posts/projects.
	- Use member and home pages as hubs/entrances.

- [ ] Figure out how to lightly theme each project so that it has more of its own identity

- [ ] Figure out some kind of services / how to engage with us / contact us page. (How to do this while still being individual-member-centric?)

- [ ] Figure out how to integrate the Yak Collective Twitter list? (Again, probably easiest in Gatsby.)

- [ ] Figure out a way to archive incoming news posts (right now, if a post disappears from a member's feed, it will disappear from the site during the next rebuild)

- [ ] Revisit use of Google Analytics on the site (some folks on Discord have expressed GDPR worries)
