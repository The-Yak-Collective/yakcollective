---
title: AWS Deep Dive
date: 2022-11-19 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-19-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Creating a Private API in Amazon API Gateway

Private APIs can only be interacted with from inside of an AWS VPC, via a special VPC endpoint interface. These endpoints can also be accessed through on-prem systems via Amazon Direct Connect (the AWS site-to-site VPN). Access to VPC endpoints can be controlled by both security groups and resource policies with the `aws:SourceVpc` / `aws:SourceVpce` conditions that are attached to the API (set) in API Gateway.

- [Creating a private API in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-private-apis.html)

### Setting up CloudWatch Logging for a REST API in API Gateway

API execution logs are set up and managed automatically by API Gateway, but _access_ logging must be manually configured. Access logs can log any `$context` variables, but cannot log any other API variables. Note that `$context.requestId` can be overridden on the client side by setting the `x-amz-RequestId` header, but `$context.extendedRequestId` is set by API Gateway itself and only revealed to the client in the `x-amz-apigw-id` response header). (Given these limitations, it’s unclear why anyone would ever bother with `$context.requestId`, though I suppose it might be useful for debugging…)

- [Setting up CloudWatch logging for a REST API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/set-up-logging.html)
