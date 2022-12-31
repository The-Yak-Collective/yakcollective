# TODO

* [x] Tweet new RSS entries + push to Discord (avoid duplication)
	* [x] Create Twitter & Discord posts along with blog posts
	* [x] Move Twitter & Discord posts into staging directory IFF timestamp is later than the last run
		* [x] Bring back the last-run timestamp!
	* [x] Update Twitter posts to use Twitter handle or professional name
	* [x] Script to push out the (lexical) oldest post to Discord
	* [x] Script to push out the (lexical) oldest tweet to Twitter
* [x] Completely remove yak-of-the-day functionality
* [x] Write a script to post service usage to Discord
* [ ] Create hourly site update automation
	* [x] Tweet
	* [x] Discord Push
	* [x] Pull RSS feeds
	* [x] Service health check to Discord
	* [ ] Automatic site rebuild
    	* [ ] Install the native Ubuntu version of minify!
        	* [ ] Figure out how to support this in local build environments too...
* [ ] Merge changes into `prod`
* [ ] Deactivate IFTTT!
