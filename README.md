# The Yak Collective

Home page of the Yak Collective projects.

## Updating Members

Member data can be found in `_data/members.yml`. Set `partner` to `true` to include in the _Partners_ block. Add (or remove) elements from `feeds` to tweak fetched posts.

## Make It Go

There are a couple of options to build remotely...

1. The page should automatically rebuild whenever this repo is updated.

2. Hit the following URL with a POST request: https://api.netlify.com/build_hooks/5ea6f1307444a7e4d60bf51c

	```sh
	curl -X POST -d '{}' https://api.netlify.com/build_hooks/5ea6f1307444a7e4d60bf51c
	```

3. If you do nothing, an [automation in IFTTT](https://www.11ty.dev/docs/quicktips/netlify-ifttt/) will automatically trigger a rebuild once a day using a process similar to **(2)**.

To build locally, just run `yak-build.sh`.
