---
title: AWS Deep Dive
date: 2022-10-16 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-16-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Gateway Responses in API Gateway

Responses generated directly by the API Gateway (MOCK responses, some error messages, etc.) are generically called “gateway responses”. They can use a mapping template, but this template is _not_ a VTL script (an internal template supporting only variable substitution is used instead). `$context`, `$stageVariables`, and `method.request` objects are all accessible within gateway responses.

Note that only pre-defined error types can be remapped using gateway responses; it is not possible to define _new_ error types/responses using this process.

- [Gateway responses in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-gatewayResponse-definition.html)

### Enabling CORS for a REST API Resource

Basic requirements of a “simple” cross-origin request:

- Uses GET, HEAD, or POST.
- Includes the `Origin` header.
- Is `text/plain`, `multipart/form-data`, or `application/x-www-form-urlencoded`.
- Does not use any non-standard headers.

Non-simple requests require the use of CORS. It’s the payload MIME type restrictions that really get you here. Even responses to “simple” requests in API Gateway need to include an `Access-Control-Allow-Origin` header, however.

Non-simple requests require the browser to make a “preflight request” first, which is an OPTIONS request including the following headers:

- `Origin`
- `Access-Control-Request-Method`
- `Access-Control-Request-Headers`

The API is then expected to issue a response with the following headers (these headers should _also_ be present in actual, non-OPTIONS API responses):

- `Access-Control-Allow-Methods`
- `Access-Control-Allow-Headers`
- `Access-Control-Allow-Origin`

Additionally, if any authentication is required (for example, login cookies are not present), the authentication process is expected to be initiated during this stage.

For non-MOCK, non-proxy integrations the API Gateway will attempt to automatically configure the proper preflight response, though the documentation notes that this doesn’t always work (and configuration is _explicitly_ manual for non-GET requests). In proxy integrations, the backend service is expected to handle preflight itself.

When CORS needs to be configured, this must be done for all defined APIs - unlike validators, CORS settings are _not_ inherited.

- [API Gateway: Enabling CORS for a REST API resource](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-cors.html)

### Working With Binary Media Types for REST APIs

Interestingly, all proxy integrations in the API Gateway require binary data to be base64 encoded, but non-proxy integrations are more flexible. (The API Gateway can even encode/decode base64 data as part of the request/response handling pipeline, which makes the strict requirements for proxy integrations all the more puzzling.) That said, APIs that handle binary data need to be explicitly configured, _in the proper direction_ (request/response)! Binary data can only be passed through if the client provides a `Content-Type` that has been marked as carrying binary data in the API Gateway configuration for the API.

Annoyingly, API Gateway only inspects the first MIME type in the `Accept` header when dealing with binary data being sent _from_ the backend _to_ the client. Since it’s generally not possible to control the order of the `Accept` header, this means that the `binaryMediaTypes` list for the API needs to be configured in an exhaustive fashion.

The `contentHandling` property in API Gateway determines how MIME types listed in `binaryMediaTypes` are handled, though it’s probably best to refer to the tables in Amazon’s documentation as `CONVERT_TO_BINARY` and `CONVERT_TO_TEXT` don’t always behave in an 100% consistent fashion. (Even leaving this undefined won’t save you, however, as whether or not the API Gateway uses base64 encoding for _responses_ can get wacky. Given the prevalence of AWS and the wackiness of API Gateway’s handling of binary media types, the number of APIs I’ve seen that encode binary data as base64 blobs embedded in JSON responses suddenly makes sense - this is probably the only way to ensure 100% consistent handling of non-text data over an API that is managed with API Gateway.)

(To be continued…)

- [API Gateway: Working with binary media types for REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-payload-encodings.html)
