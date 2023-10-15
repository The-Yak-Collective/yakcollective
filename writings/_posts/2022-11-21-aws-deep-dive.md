---
title: AWS Deep Dive
date: 2022-11-21 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-21-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working With HTTP APIs

HTTP APIs are also REST APIs - they just have fewer features, but cost less per call. HTTP APIs can also be used with Lambda functions; their main distinguishing feature is that client calls are passed in full to the backend, and backend responses are passed in full to the requesting client.

Lambda authorizers are _not_ supported for HTTP APIs, though OpenID Connect and OAuth2 authorization methods are supported.

- [Amazon API Gateway: Working with HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html)

### Working With Routes for HTTP APIs in API Gateway

HTTP APIs support the ANY pseudo-method, path variables, and query string parameters, just like API Gateway REST APIs (though unlike REST APIs, by default HTTP APIs pass query parameters through unchanged to the backend).

They also support the creation of a `$default` route, which is used for any unhandled methods (i.e., method/path tuples). By default, requests that fall through to the `$default` route are passed on to the backend with the same method, path, and query parameters that they were received with by API Gateway.

- [Working with routes for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-routes.html)

### Controlling and Managing Access to an HTTP API in API Gateway

HTTP APIs support using Lambda functions, JWT tokens, and IAM roles/policies for access control.

Lambda authorizers for HTTP APIs receive a JSON payload in a fixed format from API Gateway and then must respond with either a boolean `isAuthorized` (which provides authorization for the _entire_ API) or an IAM policy (which can allow or deny access for specific routes). The authorizer can also supply additional `$context` variables to be passed to the actual backend of the API call. API Gateway can also pre-check that appropriate “identity sources” are being passed in, and immediately respond (without invoking the Lambda authorizer) if it is not. If an identity source is specified in API Gateway, then authorizer responses can also be cached (using the source as the cache key).

For JWT authorization, API Gateway validates a JWT that is presented in a configured identity source. Tokens must include a scope property listing permitted API routes. API Gateway doesn’t issue appropriate JWT tokens - some other system is expected to issue these to the client. All claims in a JWT are passed along to the backend.

IAM authorization requires that requests be Sigv4 signed.

- [Controlling and managing access to an HTTP API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-access-control.html)

### Configuring Integrations for HTTP APIs in API Gateway

HTTP API supports using Lambda functions, other web servers, other Amazon services, and VPC resources as backends.

Like Lambda authorizers, backend Lambda functions are provided input in a specific format and are expected to reply in a specific format. Unlike REST APIs, subsequent mappings are not configurable.

HTTP server backend are more-or-less freeform: API Gateway passes the request (including the path) unchanged to the backend, and returns the backend’s response directly to the client. The one wrinkle is that API Gateway _does_ allow the request path to be rewritten; path variables specified in the matched route can be used in the rewritten path.

Finally, AWS services can be called directly as API backends. These integrations are configured directly in API Gateway; values to pass to the backend service can be specified using parameters provided by the client, stage variables, or static values. The number, name, and constraints will depend on the backend service being configured. API Gateway will access the configured service using an IAM role that must be manually configured.

(Unfortunately, only a handful of AWS services can be directly integrated with HTTP APIs - EventBridge, SQS, AppConfig, Kinesis, and StepFunctions. These integrations further only support a handful of actions. So AWS service integration isn’t nearly as flexible as it initially sounds.)

VPC resources are exposed to API gateway using “private integrations”. Any VPC resource in AWS Cloud Map can be connected in this way. Private integrations are really just HTTP server integrations that are routed over a VPC link (and to an ARN instead of a normal URL). Note that VPC links become inactive after 60 days, and will fail for a few minutes before becoming active again if API requests resume.

- [Configuring integrations for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-develop-integrations.html)

### Configuring CORS for an HTTP API in API Gateway

When CORS is turned on for an API, API Gateway will automatically respond to preflight OPTIONS requests (no special routes need to be configured).

One disadvantage of using a `$default` route is that it will trap preflight OPTIONS requests. Since preflight requests are do not include any authorization, an additional `OPTIONS /{proxy+}` route needs to be added that also does not require any authorization. (I’m 90% certain that OPTIONS requests in this case will still need to be handled by the backend, though the API Gateway documentation is silent on this point.)

- [Configuring CORS for an HTTP API](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-cors.html)
