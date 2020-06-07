// Load required packages
//
const express = require("express");
const bodyParser = require("body-parser");
const moment = require("moment");
const chrono = require("chrono-node");
const accents = require('remove-accents');
const { Octokit } = require("@octokit/rest");

// Lambda function handler
//
exports.handler = async function(event, context) {

	// Init GitHub connection
	//
	//const github = new Octokit({
	//	auth: process.env.GH_TOKEN
	//});

	// Reject requests without the right secret
	//
	//if (event.token !== process.env.WEBHOOK_TOKEN) {
	//	return {
	//		statusCode: 401,
	//		body: "Access denied"
	//	}
	//}

	// Set incoming post category, or none
	//
	//var postPath;
	//if (event.category === null || event.category.length === 0) {
	//	postPath = "_posts"
	//} else {
	//	postPath = event.category + "/_posts"
	//}

	// Demo return
	//
	return {
		statusCode: 200,
		//body: "Eventually, I will push posts to " + process.env.GH_USER_OR_TEAM + "/" + process.env.GH_REPO + ":" + process.env.GH_BRANCH + "/" + postPath
		body: JSON.stringify(event)
	}
}
