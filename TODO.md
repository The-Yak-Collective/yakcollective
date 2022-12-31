# TODO

* [x] Tweet new RSS entries + push to Discord (avoid duplication)
	* [x] Create Twitter & Discord posts along with blog posts
	* [x] Move Twitter & Discord posts into staging directory IFF timestamp is later than the last run
		* [x] Bring back the last-run timestamp!
	* [x] Update Twitter posts to use Twitter handle or professional name
	* [x] Script to push out the (lexical) oldest post to Discord
	* [x] Script to push out the (lexical) oldest tweet to Twitter
* [x] Completely remove yak-of-the-day functionality
* [ ] Write a script to post service usage to Discord
	* `curl -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN"  https://api.github.com/orgs/${ACCOUNT_SLUG}/settings/billing/actions | jq.`
	* `curl -H "User-Agent: MyApp $ACCOUNT_EMAIL" -H "Authorization: Bearer $NETLIFY_TOKEN" https://api.netlify.com/api/v1/${ACCOUNT_SLUG}/builds/status | jq .`
* [ ] Create GitHub Actions workflows
	* [x] Tweet
	* [x] Discord Push
	* [x] Pull RSS feeds
	* [ ] Service health check to Discord
	* [ ] Automatic site rebuild (daily? hourly?)
* [ ] Deactivate IFTTT!
* [ ] Merge changes into `prod`
