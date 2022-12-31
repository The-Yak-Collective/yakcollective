---
title: AWS Deep Dive
date: 2022-10-17 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-17-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Working With Binary Media Types for REST APIs (Continued)

While binary media types need to be specified individually, API Gateway does support wildcarding. In particular, `*/*` will match all files, though given the sometimes strange behavior of API Gateway that seems potentially inadvisable; I suspect something like `image/*` may work better (though even here there are potential problems - for example, handling SVGs).

When converting incoming binary data to a base64 encoded string, a mapping template can be provided in order to provide the appropriate surrounding graffiti (normally JSON blob structure). For obvious reasons, a mapping is not necessary (or advisable) when converting a base64 string to a binary stream.

(The API examples AWS provides in the documentation for uploading base64 encoded binary data use `Content-Type: application/json` with a body that’s a raw - unwrapped! - base64 string. While this makes sense within the context of API Gateway, abusing `Content-Type` in this fashion just seems really bad to me.)

- [2022-10-16 - AWS Deep Dive (API Gateway: Working With Binary Media Types for REST APIs, Part 1](https://cardboard-iguana.com/log/2022-10-16-aws-deep-dive.html)
- [API Gateway: Working with binary media types for REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-payload-encodings.html)
