# The Yak Collective’s Website
![Netlify Status|100](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)

Currently in a significant state of flux.

## Editing the Website
This site is actually a [Foam](https://foambubble.github.io/foam/)/[Obsidian](https://obsidian.md) wiki; to edit, clone the repository, open it in the appropriate application, enable/install the recommended extensions, and go!

You can also open the site directly in [VS Code on the web](https://vscode.dev/) by simply typing `.` (“period”) when viewing this file in GitHub.

This `README` and files in the `private` directory are *not* included in the final build, while [index.md](../index.md) file becomes the site homepage.

## Building the Website Locally
```bash
# New directions needed...
```

## Ways to Contribute
[Current website issues and projects on GitHub.](https://github.com/The-Yak-Collective/yakcollective/issues) Pull requests and ideas welcome!

Conversations happen on [the Discord ⌗infrastructure channel](https://discord.com/channels/692111190851059762/704369362315772044).

## TODO

- [ ] Foam/Obsidian/Quartz-ify all files
	- `projects/astonishing stories/index.md`
	- `projects/astonishing stories/Agglomerizing the Aesthetic.md`
	- `projects/astonishing stories/Department of Restoration.md`
	- `projects/astonishing stories/Mechanical Turks All the Way Down.md`
	- `projects/astonishing stories/Out of the Loop.md`
	- `projects/astonishing stories/Wholeness in a Timeless Activity.md`
	- `projects/astonishing stories/Your Payment is Ready.md`
- [ ] Integrate in newsletters from `.automation/var/cache/pluto/newsletter/*`
- [ ] Make sure that all all pages are linked to each other
- [ ] Make sure text works well everywhere
	- [ ] Obsidian
	- [ ] Foam
	- [ ] GitHub
- [ ] Recreate build and automation infrastructure using [Quartz](https://github.com/jackyzha0/quartz)
	- `.automation`
	- `.github`
- [ ] Reimplement join page form using [Netlify Forms](https://docs.netlify.com/forms/setup/)
- [ ] Move [IT infrastructure map](https://roamresearch.com/#/app/ArtOfGig/page/w6uAG9Pig) from DOT/Graphviz to something like Mermaid
	- ChatGPT makes a decent first-pass, but it doesn't really understand multi-path commands
	- The goal here is Foam/GitHub compatibility
	- Add it to the `private` directory
	- Probably should rebuild SVG on update...
	- Archive the [current repo](https://github.com/The-Yak-Collective/infrastructure-map) when done
	- Not *technically* part of this project, but makes sense to slot in here...
