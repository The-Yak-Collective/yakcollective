# The Yak Collective’s Website
![Netlify Status|100](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)

Currently in a significant state of flux.

## Editing the Website
This site is actually a [Foam](https://foambubble.github.io/foam/)/[Obsidian](https://obsidian.md) wiki; to edit, clone the repository, open it in the appropriate application, enable/install the recommended extensions, and go!

You can also open the site directly in [VS Code on the web](https://vscode.dev/) by simply typing `.` (“period”) when viewing this file in GitHub.

This `README` and files in the `private` directory are *not* included in the final build, while [index.md](index.md) file becomes the site homepage.

## Building the Website Locally
```bash
# Build the website
#
./.automation/build.sh

# Optionally view the website locally via http://127.0.0.1:8080
#
./.automation/build.sh serve

# Push the website to Netlify.
#
export NETLIFY_AUTH_TOKEN=XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
export NETLIFY_SITE_ID=xxxxxxxx-xxxxxxxx-00000000

npx netlify-cli deploy \
	--dir .automation/www \
	--message "Local development deploy $(date -u +"%Y%m%d%H%M%S")/${USER}@${HOST}" \
	--prod
```

## Ways to Contribute
[Current website issues and projects on GitHub.](https://github.com/The-Yak-Collective/yakcollective/issues) Pull requests and ideas welcome!

Conversations happen on [the Discord ⌗infrastructure channel](https://discord.com/channels/692111190851059762/704369362315772044).
