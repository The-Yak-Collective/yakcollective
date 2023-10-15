---
title: AWS Deep Dive
date: 2022-09-29 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-09-29-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Beginning some notes about the Amazon API Gateway.

## What is Amazon API Gateway?

API Gateway is basically a tool for building the _infrastructure_ associated with _managing_ REST and WebSocket APIs - traffic management, authorization and access control, monitoring, request routing, etc. CloudFormation can be used with the API Gateway to spin up new APIs.

API Gateway is typically deployed with Lambda backends, though there are a lot of other options too.

REST APIs are defined as a collection of “resources” and “methods”, where a “resource” is some object (specified using a path) and a “method” is an action performed on that object specified (specified as an HTTP verb + path tuple). For REST APIs, API Gateway translates front end “methods” into back end “integrations”, essentially mapping incoming requests to backend calls, and then mapping the resulting responses back for the client. method-to-integration and integration-to-method mappings are written using the “Velocity Template Language”.

API Gateway’s “HTTP API” functionality is similar to its REST API functionality (the resulting APIs are, in fact, still REST APIs!), but sees the Gateway simply proxying requests between the front end and back end. This makes the entire process more efficient, but means that the back end is restricted to services that can understand the API requests without any intermediate mapping. The HTTP API option also strips out a number of other features (though it _does_ support JWT authorization at the Gateway level, while the REST API option surprisingly requires a Lambda function to handle this). This simplicity allows for a more responsive (and less expensive) system, however. (After looking through the feature tables, I’m pretty convinced that the HTTP API option will only work for _very_ simple APIs.)

WebSockets APIs provide bi-directional data push functionality. The restrictions seem to be somewhere between the REST and HTTP API paradigms. API Gateway can route incoming messages to different back ends depending on their content.

API Gateway endpoints always follow the same naming convention: `${API_ID}.execute-api.${AWS_REGION}.amazonaws.com`.

- [What is Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)
