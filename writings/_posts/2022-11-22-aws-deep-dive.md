---
title: AWS Deep Dive
date: 2022-11-22 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-22-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working With HTTP APIs

- [Amazon API Gateway: Working with HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api.html)

### Transforming API Requests and Responses in API Gateway

HTTP APIs _can_ modify inbound requests and outbound responses, but in much more limited ways than REST APIs.

Inbound requests can have their headers, query string (if applicable), and path modified. While request bodies cannot be modified, API Gateway can extract values from them (or at least from the first 100 KB).

Outbound responses can have their headers and status codes modified. As with inbound requests, the response body can be used as a data source, even if it can’t be modified.

- [Transforming API requests and responses](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-parameter-mapping.html)

### Working with OpenAPI Definitions for HTTP APIs in API Gateway

As with REST APIs, HTTP APIs can be exported and imported to OpenAPI 3.0 definition files. The import/export process can even be used to “convert” a REST API into an HTTP API, though not all REST API attributes (for example, request validation) will be imported (since HTTP APIs don’t have all of the same features).

- [Working with OpenAPI definitions for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-open-api.html)

### Working with Stages for HTTP APIs in API Gateway

Stage variables work more-or-less the same for HTTP APIs as they do for REST APIs.

- [Working with stages for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-stages.html)

### Setting Up Custom Domain Names for HTTP APIs in API Gateway

Custom domains work more-or-less the same for HTTP APIs as they do for REST APIs (modulo the absence of `$context` variables).

- [Setting up custom domain names for HTTP APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/http-api-custom-domain-names.html)
- [2022-10-31 - AWS Deep Dive (Setting Up Custom Domain Names for REST APIs in API Gateway, Part 1)](https://cardboard-iguana.com/log/2022-10-31-aws-deep-dive.html)
- [2022-11-03 - AWS Deep Dive (Setting Up Custom Domain Names for REST APIs in API Gateway, Part 2)](https://cardboard-iguana.com/log/2022-11-03-aws-deep-dive.html)
