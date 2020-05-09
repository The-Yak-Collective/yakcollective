# The Yak Collective

Home page of the Yak Collective projects.

## Updating Members

Member data can be found in `_data/members.yml`. Set `partner` to `true` to include in the _Partners_ block. Add (or remove) elements from `feeds` to tweak fetched posts.

## Make It Go

To build things locally...

```sh
bundler config set path vendor/bundle
./yak-build.sh
```

To build things on Netlify...

1. Just push a change to the repo, or

2. If you do nothing, an [automation in IFTTT](https://www.11ty.dev/docs/quicktips/netlify-ifttt/) will automatically trigger a rebuild once a day using a webhook.
