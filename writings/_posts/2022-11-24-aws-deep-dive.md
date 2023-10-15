---
title: AWS Deep Dive
date: 2022-11-24 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-24-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working With WebSocket APIs

- [Amazon API Gateway: Working with WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html)

### Invoking WebSockets Backend Integrations in API Gateway

WebSocket APIs in API Gateway support messages up to 128 KB is size, chunked into blocks of at most 32 KB. Raw binary data is not supported.

Routes need to be configured _before_ integrations for WebSocket APIs in the API Gateway console (this is less flexible than HTTP or REST APIs), and multiple routes cannot be associated with a single integration. These are both limitations of the API Gateway console, however, as using something like the AWS CLI that talks to the API Gateway API directly allows routes and integrations to be set up in any order, and for multiple routes to be paired with a single integration.

In addition to using data from request bodies for routing, API Gateway can also perform body validation before passing the request off to the backend. Unlike HTTP and REST APIs, explicit response routes need to be defined for WebSocket APIs to enable communication from the backend _to_ the client.

Routes are defined by looking at the value of a specific JSON property; messages without that property (including non-JSON messages), or where that property does not match a defined route, are sent to the `$default` route.

- [Invoking your backend integration: `$default` Route and custom routes](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-routes-integrations.html)

### WebSocket Selection Expressions in API Gateway

Route keys can actually include variables that refer to authentication headers, or the outcome of Lambda authorizers; however, everything else still needs to come from the incoming JSON body.

As of this writing, all route responses are handled in the same way (by a defined `$default` response route). The API Gateway documentation indicates that this will eventually change, however.

- [WebSocket selection expressions in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-selection-expressions.html)
