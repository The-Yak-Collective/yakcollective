// Load required packages
//
const moment = require("moment");
const chrono = require("chrono-node");
const accents = require("remove-accents");
const axios = require("axios");
const { Octokit } = require("@octokit/rest");

// Lambda function handler
//
exports.handler = async function(event, context) {

	// Reject requests without the right secret
	//
	if (event.queryStringParameters.token !== process.env.WEBHOOK_TOKEN) {
		return {
			statusCode: 401,
			body: "Access denied"
		};
	};

	// Set incoming post category, or none
	//
	var postPath;
	var postCategory;
	if (! (event.queryStringParameters).hasOwnProperty("category") || event.queryStringParameters.category === null || event.queryStringParameters.category.length === 0) {
		postCategory = "";
		postPath = "_posts";
	} else {
		postCategory = event.queryStringParameters.category;
		postPath = postCategory + "/_posts";
	};

	// Cleanup formatting of incoming post, replace special chracters, etc.
	//
	//    1. Replace ||| with newlines
	//    2. Replace |@ with literal |
	//    3. Replace @@@ with <!--more-->
	//    4. Strip empty elements at the beginning of any lists
	//    5. Strip empty elements at the end of any lists
	//    6. Replace any double <p><p> with a single <p>
	//    7. Replace any double </p></p> with a single </p>
	//    8. Replace { with &#x007b; to work around Jekyll parsing weirdness.
	//    9. Replace } with &#x007d; to work around Jekyll parsing weirdness.
	//   10. Replace % with &#x0023; to work around Jekyll parsing weirdness.
	//   11. Replace the sequence .### with just . (since this implies that we don't need ###)
	//   12. Finally, replace ### with ...
	//
	var postContent = (event.body).replace(/\|\|\|/g, "\n");
	postContent = postContent.replace(/\|@/g, "|");
	postContent = postContent.replace(/@@@/g, "<!--more-->");
	postContent = postContent.replace(/\[ ("")? ?,/, "[ ");
	postContent = postContent.replace(/, ?("")? \]/, " ]");
	postContent = postContent.replace(/<p><p>/, "<p>");
	postContent = postContent.replace(/<\/p><\/p>/, "</p>");
	postContent = postContent.replace(/{/, "&#x007b;");
	postContent = postContent.replace(/}/, "&#x007d;");
	postContent = postContent.replace(/%/, "&#x0023;");
	postContent = postContent.replace(/\. *###/, ".");
	postContent = postContent.replace(/###/, "...");

	// Post date or now.
	//
	var postDate;
	var dateSearch = postContent.match(/date: ?(.+)\n/);
	if (dateSearch !== null && dateSearch.length > 0) {
		postDate = chrono.parseDate(dateSearch[1]);
	} else {
		postDate = new Date();
	};
	postContent = postContent.replace(/date:.*\n/, "");
	postContent = postContent.replace(/---\n/, "---\ndate: " + moment(postDate).format("YYYY-MM-DD HH:mm:ss ZZ") + "\n");

	// Figure out the post title. Abort if none is set.
	//
	var postTitle;
	var titleSearch = postContent.match(/title: ?(.+)\n/);
	if (titleSearch !== null && titleSearch.length > 0) {
		postTitle = titleSearch[1].trim().replace(/^"/, "").replace(/"$/, "");
	} else {
		return {
			statusCode: 400,
			body: "Post title not found"
		};
	};
	postContent = postContent.replace(/title:.*\n/, "");
	postContent = postContent.replace(/---\n/, "---\ntitle: |\n  " + postTitle + "\n");

	// Figure out the post URL. Abort if none is set.
	//
	var postURL;
	var urlSearch = postContent.match(/original_link: ?(.+)\n/);
	if (urlSearch !== null && urlSearch.length > 0) {
		postURL = urlSearch[1].trim().replace(/^"/, "").replace(/"$/, "");
	} else {
		return {
			statusCode: 400,
			body: "Post URL not found"
		};
	};

	// Create slug (for use in file names).
	//
	var slugTitle = moment(postDate).format("YYYY-MM-DD-") + (accents.remove(postTitle)).toLowerCase().replace(/[^a-z0-9]/g, "-").replace(/-+/g, "-");

	// Post content to GitHub, after:
	//
	//   https://dev.to/remotesynth/build-your-own-api-with-netlify-functions-and-zapier-webhooks-part-2-j55
	//
	try {
		const github = new Octokit({
			auth: process.env.GH_TOKEN
		});
		await github.repos.createOrUpdateFile({
			owner: process.env.GH_USER_OR_TEAM,
			repo: process.env.GH_REPO,
			branch: process.env.GH_BRANCH,
			path: postPath + "/" + slugTitle + ".html",
			message: "Post automatically pushed from IFTTT",
			content: new Buffer(postContent).toString("base64")
		});
	} catch (gitHubError) {
		return {
			statusCode: 500,
			body: "Post creation in GitHub failed"
		};
	};

	// Post to URL using Axios, after:
	//
	//   https://attacomsian.com/blog/node-http-post-request
	//
	if (postCategory === "writings") {
		const discordURL = "https://discordapp.com/api/webhooks/" + process.env.DISCORD_CHANNEL + "/" + process.env.DISCORD_WEBHOOK_TOKEN;
		const discordContent = {
			content: postTitle + " " + postURL
		}
		try {
			await axios.post(discordURL, discordContent);
		} catch (discordError) {
			return {
				statusCode: 500,
				body: "Post notification in Discord failed"
			};
		}
	}

	// Return success
	//
	return {
		statusCode: 201,
		body: "Success"
	};
};
