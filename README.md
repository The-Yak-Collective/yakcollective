# The Yak Collective

Home page of the Yak Collective projects.

[![Netlify Status](https://api.netlify.com/api/v1/badges/943ff646-41b6-4b4b-ab86-a891698c72c7/deploy-status)](https://app.netlify.com/sites/practical-lichterman-20c7e0/deploys)

## Updating Members

Member data can be found in `_data/members.yml`. Set `partner` to `true` to include in the _Partners_ block. Add (or remove) elements from `feeds` to tweak fetched posts.

## Development

Significant website changes should be made using short-lived [topic branches](https://git-scm.com/book/en/v2/Git-Branching-Branching-Workflows) that are merged into `netlify-prod` when ready. The Yak Collective Netlify account can be used to create temporary websites when such changes need to be reviewed broadly.

## Make It Go

To build things locally...

```sh
bundler config set path vendor/bundle
./yak-build.sh
```

When doing local development, you may want to run `./yak-build.sh serve` rather than just `./yak-build`; this will fire up Jekyll's local server mode so that you can connect to http://localhost:4000 and browse the current version of the site.

To build things on Netlify...

1. Just push a change to the repo, or

2. If you do nothing, an [automation in IFTTT](https://www.11ty.dev/docs/quicktips/netlify-ifttt/) will automatically trigger a rebuild once a day using a webhook.
