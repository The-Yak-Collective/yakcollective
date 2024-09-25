# The Yak Collective’s Website
![Netlify Status|100](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)

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
	- `projects/New Old Home.md`
	- `projects/Online Governance Primer.md`
	- `projects/Astonishing Stories/index.md`
	- `projects/Astonishing Stories/Agglomerizing the Aesthetic.md`
	- `projects/Astonishing Stories/Department of Restoration.md`
	- `projects/Astonishing Stories/Mechanical Turks All the Way Down.md`
	- `projects/Astonishing Stories/Out of the Loop.md`
	- `projects/Astonishing Stories/Wholeness in a Timeless Activity.md`
	- `projects/Astonishing Stories/Your Payment is Ready.md`
	- `projects/Future Frontiers/index.md`
	- `projects/Future Frontiers/01.01.01 On Horizons.md`
	- `projects/Future Frontiers/02.01.01 Democratized Underwater Exploration.md`
	- `projects/Future Frontiers/02.01.02 Democratized Underwater Exploration.md`
	- `projects/Future Frontiers/02.01.03 Democratized Underwater Exploration.md`
	- `projects/Future Frontiers/02.01.04 Democratized Underwater Exploration.md`
	- `projects/Future Frontiers/02.02.01 The Promise of Nanosatellites for Developing Nations.md`
	- `projects/Future Frontiers/02.02.02 The Promise of Nanosatellites for Developing Nations.md`
	- `projects/Future Frontiers/02.02.03 The Promise of Nanosatellites for Developing Nations.md`
	- `projects/Future Frontiers/03.01.01 Starship Gold Rush.md`
	- `projects/Future Frontiers/03.01.02 Starship Gold Rush.md`
	- `projects/Future Frontiers/05.01.01 Designer Metabolism and Minds.md`
	- `projects/Future Frontiers/05.01.02 Designer Metabolism and Minds.md`
	- `projects/Future Frontiers/99.99.99 Contribute to Future Frontiers.md`
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
	- The goal here is Foam/GitHub compatability
	- Add it to the `private` directory
	- Probably should rebuild SVG on update...
	- Archive the [current repo](https://github.com/The-Yak-Collective/infrastructure-map) when done
	- Not *technically* part of this project, but makes sense to slot in here...
