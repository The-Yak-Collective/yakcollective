---
title: AWS Deep Dive
date: 2022-10-10 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-10-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-10-10

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Controlling and Managing Access to a REST API in API Gateway (Continued…)

Lambda authorization functions for the API Gateway can be called across accounts, though the setup process definitely shows that this is a bit of a hack / afterthought. Still, doing this allows authorization and API functions to be clearly separated, and also allows a single authorization method to be shared across multiple API Gateways (since the recommendation is only to deploy a single API Gateway per account). Cross-account Cognito user pools can be configured in a similar fashion.

Updating authorization methods seems to always require the apigateway:POST (create) and apigateway:PATCH (update) IAM permissions, though the target resources differ depending on which authorization method is being used.

- [2022-10-04 - AWS Deep Dive (Controlling and Managing Access to a REST API in API Gateway, Part 1)](https://cardboard-iguana.com/log/2022-10-04-aws-deep-dive.html)
- [2022-10-08 - AWS Deep Dive (Controlling and Managing Access to a REST API in API Gateway, Part 2)](https://cardboard-iguana.com/log/2022-10-08-aws-deep-dive.html)
- [Controlling and managing access to a REST API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-control-access-to-api.html)

### Setting up REST API Integrations

Integration request URIs can either be URLs or ARNs. Using ARNs allows selected API requests to be mapped directly to Amazon services (such as S3), though IMHO I’ve found this approach inadvisable (because it’s _really_ easy to expose too much functionality/data this way!).

(If I read this section correctly, then one way to think of the distinction between method request/response and integration request/response is that the method determines request/response _formatting_, while the integration determines request/response _variable mapping_.)

In addition to integrating with Lambda functions, generic AWS services, and generic HTTP endpoints, API Gateway can also act as a “mock” endpoint itself for the purpose of integration testing. In general, integrations can be divided into “proxy” and “non-proxy” types; the difference is in whether the request/response is passed unchanged from client to backend (and vice versa), or whether a more complicated transform using integration requests/responses needs to be defined.

(It’s worth noting that Lambda proxies aren’t _true_ proxies, in that the request isn’t _literally_ passed through to the backend (or back to the client). Rather, the request is translated to a standardized JSON format, and the response is expected in a standardized format, which is then automatically re-mapped/formatted into a more REST-like HTTP response by the API Gateway.)

It sounds like using a Lambda proxy requires the use of both the greedy `{proxy+}` path element and the virtual `ANY` HTTP verb…? Which I suppose makes sense (as this allows you to think of the Lambda function as sitting at the “root” of a particular path).

As one might suspect, regular expressions in the API Gateway are all Java-flavored.

(To be continued…)

- [Amazon API Gateway: Setting up REST API Integrations](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-integration-settings.html)
