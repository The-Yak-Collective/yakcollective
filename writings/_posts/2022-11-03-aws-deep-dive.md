---
title: AWS Deep Dive
date: 2022-11-03 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-03-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Setting Up Custom Domain Names for REST APIs in Amazon API Gateway (Continued)

API Gateway custom domains are all managed through CloudFront.

APIs are mapped to base paths (which might be just `/`) off of the custom domain; thus, multiple APIs can (potentially) use the same custom domain (just with different base paths). For _regional_ custom domains (this is a weird restriction…), _subsets_ of multiple APIs can be rooted in different base paths with multiple components. To determine which API to route a request to, API Gateway chooses the API with the longest full path (base path + API path). One consequence of this is that for regional custom domains, one API can be “mounted” inside of another.

Once a custom domain is set up, the default API Gateway endpoint can be disabled. However, doing so disables it for _all_ stages of that API.

- [2022-10-31 - AWS Deep Dive (Setting Up Custom Domain Names for REST APIs in Amazon API Gateway, Part 1)](https://cardboard-iguana.com/log/2022-10-31-aws-deep-dive.html)
- [Setting up custom domain names for REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-custom-domains.html)

### Enabling API Caching to Enhance Responsiveness of API Gateway

By default, only GET API methods are cached. This can be tuned on a per-method basis, however. Custom headers and URL paths / query string can also be used as cache keys to further ensure that API responses are not inappropriately cached together.

Clients can force a cache reload by sending the `Cache-Control: max-age=0` HTTP header. This is actually allowed by default, and must be specifically denied using an IAM policy (which you probably want to do, less user activity negate your caching setup).

- [Enabling API caching to enhance responsiveness](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-caching.html)

### Enabling Payload Compression for an API in API Gateway

Compression is _not_ enabled in API Gateway by default, but like many things can be enabled by setting a single property - in this case, `minimumCompressionsSize`. Any value between 0 and 10 MB (note that the variable is in bytes) will enable compression for responses with a size _greater_ than that value (if the client has indicated that compression is supported). Compression is disabled by removing the parameter or setting it to null.

- [Enabling payload compression for an API](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-gzip-compression-decompression.html)

### Creating and Using Usage Plans with API Keys in API Gateway

API Gateway can also generate API keys and tie these to per-stage usage plans in order to enable third-party developer access to a finished API. Individual API methods _cannot_ be restricted per API key, though methods can be restricted to require _an_ API key (it’s just that all such restricted methods are available to anyone with an API key for that API). API keys must be either be transmitted by the client using the `x-api-key` header or provided by a Lambda authorizer (via the returned `usageIdentifierKey` property).

- [Creating and using usage plans with API keys](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-api-usage-plans.html)
