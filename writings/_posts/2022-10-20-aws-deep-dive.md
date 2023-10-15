---
title: AWS Deep Dive
date: 2022-10-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-20-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Invoking a REST API in Amazon API Gateway

While testing an API from the API Gateway console actually invokes the API (as would be expected), it does _not_ generate CloudWatch logs (though the API Gateway will helpfully/unhelpfully show you the logs that _would_ have been sent if the request had been invoked normally).

VPC endpoints defined in API Gateway can only access _either_ the applicable public _or_ private APIs - it’s not possible to access _both_ versions of the API through the same endpoint. Despite this limitation, private APIs _can_ be accessed using both public _and_ private DNS names.

- [Invoking a REST API in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-call-api.html)
