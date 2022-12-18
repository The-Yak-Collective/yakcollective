---
title: AWS Deep Dive
date: 2022-11-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-28-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-11-28

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working With WebSocket APIs

- [Amazon API Gateway: Working with WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html)

### Create a WebSocket API in API Gateway

WebSocket APIs require the use of TLS 1.2 (API Gateway doesn’t seem to support TLS 1.3).

WebSocket APIs _cannot_ be converted into REST APIs, nor can REST APIs be turned into WebSocket APIs. (This makes sense.)

- [Create a WebSocket API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-create-empty-api.html)

### Working With Routes for WebSocket APIs in API Gateway

Route selection expressions are based around the form `$request.body.<JSON_PATH_TO_PROPERTY>`. Objects can be matched by the JSONPath, but the results will be stringified before evaluation. Multiple selection expressions can be combined into the final expression; static values can be included to make it easier to read/parse the evaluated route key’s value.

Note that the `$` is _not_ included in a custom route key name when setting up a route; only the built-in `$default`, `$connect`, and `$disconnect` route names can lead with this character.

The `$connect` route supports IAM (`AWS_IAM`) and Lambda Authorizers (`CUSTOM`) for authorization. There’s also a `NONE` option. API Gateway can also check for the presence of a valid API key when the `$connect` route is called.

Only the `$default` route can be used for responses, which is somewhat annoying as all of the (user-facing) machinery seems to exist to support route responses on custom route selections.

The `$connect` route allows a Lambda authorizer to reject connections for unsupported subprotocols (specified by the `Sec-WebSocket-Protocol` header). It’s not clear to me what this gets you, but I assume this is important functionality for people who work with WebSockets.

- [Working with routes for WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-develop-routes.html)

### Controlling and Managing Access to a WebSocket API in API Gateway

IAM policies work basically the same for WebSocket APIs as REST APIs, except that (1) WebSockets support a `ManageConnections` action that controls access to the `@connections` API, and (2) non-`@connections` routes use a different ARN format (the `@connections` API is represented as `arn:aws:execute-api:*:*:*/*/POST/@connections`).

(It’s not 100% clear _what_ the `@connections` API is. It seems to be different than the `$connect` route, and has something to do with response routes.)

The biggest difference when using a Lambda authorizer between WebSockets and REST APIs is that the `event.methodArn` is different (`arn:aws:execute-api:*:*:*/*/$connect`). Path variables (`event.pathParameters`) aren’t available and context variables (`event.requestContext`) are different too, but these pretty obviously need to be the case.

- [Controlling and managing access to a WebSocket API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-control-access.html)

### Setting up WebSocket API Integrations in API Gateway

The “Lambda Function” integration type is only for _existing_ Lambda functions that don’t/won’t require special resource permissions. All other Lambda function requests (including the automatic creation of new Lambda functions) are handled with the “AWS Service” integration type. (This strikes me as a weird and _really_ specific distinction.)

Regardless of the integration type, WebSockets APIs support a template selection process that parallels the route selection process - a template selection expression (like a route selection expression) will be used to determine a template key. The template corresponding to that key will then be used to determine which request mapping template is used to pre-process the incoming request before handing it off to the backend.

Integration responses can be pre-processed in a similar way as requests, using a “response key” that maps to a particular response template. Responses that don’t match this key are handled by the `$default` response key (and corresponding template). The big difference here is that the response key is a regular expression matching the returned backend HTTP status code, rather than a JSONPath.

Note that there is no response setup for proxy integrations; API Gateway simply passes these backend responses to the client unaltered (assuming that a response route has been configured).

- [Setting up WebSocket API integrations](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api-integrations.html)

### Request Validation for WebSocket APIs in API Gateway

Incoming WebSocket requests can be validated by API Gateway before being passed to backend integrations, just like with REST APIs. As you might expect by this point, different JSON schema request models can be used for validation, each keyed off of a model selection expression (which works just like a route selection expression). A catch-all `$default` model can also be defined.

Models can be chosen at the same time (and by the same expression) as routes, which seems like how you’d normally want to handle things.

- [Request validation](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-request-validation.html)
