---
title: AWS Deep Dive
date: 2022-10-08 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-08-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-10-08

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Controlling and Managing Access to a REST API in API Gateway (Continued…)

API Gateway policies are just another kind of resource policy. Which means that they look like S3 policies, which in turn just look like plain old IAM policies. As you would expect, API Gateway permissions can also be specified directly for IAM users.

Lambda functions used for authorization take the caller’s identity (which can be defined using bearer tokens or some combination of headers + query parameters) and are expected to return a principle name (which can be generic) + IAM policy. This IAM policy is then combined with the existing API Gateway resource policy for evaluation (explicit denials in the API Gateway policy are handled _before_ the Lambda authorization function is called, however). Policy evaluation results can be cached for up to 1 hour by the API Gateway in order to minimize calls to the Lambda authorizer, and the API Gateway can also do light pre-validation (checking token headers against a pre-defined regex, or verifying that all required parameters are present). Note that authorization requests that are denied by the API Gateway _before_ being handed off to the authorizing Lambda function are _not_ logged! Lambda authorizers can hand off authorization to external systems/entities.

When IAM is used for authorization directly, the associated policy is also combined with the API Gateway resource policy before evaluation, but IAM authentication happens _first_ (before _any_ policy is evaluated).

Cognito is handled similarly to IAM, but appears to be even more strict, as an _explicit_ allow needs to be returned by Cognito _and_ the API resource policy (if present).

Policies can also be attached to VPC endpoints to provide an additional level of protection for private APIs.

In all of these cases, authorization can be limited to only some APIs or users, allowing for fine-grained API access.

APIs using `AWS_IAM` authentication _must_ use `AWS` principals in their resource policies, and vice versa. All other authorization types must use the `*` principal.

API Gateway policy actions are limited to execute-api:Invoke and execute-api:InvalidateCache, both of which do what they sound like. Access to specific API paths and methods can be controlled using their associated resource ARNs.

API Gateway resource ARNs _can_ be specified down to the deployment stage, method, and resource - `arn:aws:execute-api:{region}:{account}:{api-id}/{stage-name}/{http-verb}/{api-path}` (`{api-id}` here is the ID of the overall API Gateway project, _not_ the ID for a particular request method). The `*` wildcard can be used on any part of this ARN (except the API project ID?). Resource ARNs are limited to 1600 bytes or 512 characters, whichever comes first.

Note that API behavior does _not_ immediately change if the associated resource policy is updated - it’s necessary to redeploy the API first.

For the API Gateway to be able to call a backend AWS service, it needs to both be given the AssumeRole privilege (to allow it to call the service on behalf of the user calling it) and explicit access to the service it is integrating with. (Presumably only the second of these is required for APIs that aren’t restricted to AWS authentication.)

(To be continued…)

- [2022-10-04 - AWS Deep Dive (Controlling and Managing Access to a REST API in API Gateway, Part 1)](https://cardboard-iguana.com/log/2022-10-04-aws-deep-dive.html)
- [Controlling and managing access to a REST API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-control-access-to-api.html)
