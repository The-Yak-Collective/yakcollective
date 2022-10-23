# TODO

* [ ] Tweet new RSS entries + push to Discord (avoid duplication)
	* [x] Create Twitter & Discord posts along with blog posts
	* [ ] Move Twitter & Discord posts into staging directory IFF timestamp is later than the most recent timestamp in the key/set sequence (or last run, if no entries for a given key/set exist)
		* [ ] Bring back the last-run timestamp!
	* [ ] Update Twitter posts to use Twitter handle or professional name
	* [ ] Script to push out the (lexical) oldest Twitter and Discord post
		* Archive pushed posts?
* [ ] Figure out how to build Yak-of-the-Day tweets (but leave this deactivated for now)
	* Create a yak-of-the-day directory
	* If today's entry isn't in the yak-of-the-day directory...
		* Construct the set of available yaks
			* Contributed to a project (INCLUDE)
			* In the writings list (INCLUDE)
			* Highlighted in the last 30 days (REMOVE)
			* Contributed to the most recent project (+1)
			* Writing in the last 30 days (+1)
			* (Easy to extend this one we have Discord information in Knack...)
		* Pick a random yak from the list
		* Store in yak-of-the-day directory
		* Create a tweet for this yak (disable for now)
		* If more than 30 historic yaks exist, remove the (lexical) oldest entry
			* Maybe archive instead?
	* Yak-of-the-Day plugin then just picks the (lexical) most recent yak from the yak-of-the-day directory
* [ ] Create GitHub Actions workflows
	* [ ] Pull RSS feeds
	* [ ] Tweet
	* [ ] Discord Push
	* [ ] Automatic site rebuild (daily? hourly?)
* [ ] Deactivate IFTTT!
* [ ] Write a script to post service usage to Discord
  * `curl -H "Accept: application/vnd.github+json" -H "Authorization: Bearer $GITHUB_TOKEN"  https://api.github.com/orgs/${ACCOUNT_SLUG}/settings/billing/actions | jq.`
  * `curl -H "User-Agent: MyApp $ACCOUNT_EMAIL" -H "Authorization: Bearer $NETLIFY_TOKEN" https://api.netlify.com/api/v1/${ACCOUNT_SLUG}/builds/status | jq .`
