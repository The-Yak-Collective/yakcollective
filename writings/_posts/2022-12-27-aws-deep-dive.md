---
title: AWS Deep Dive
date: 2022-12-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-12-27-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Security

Interesting - AWS maintains FIPS-specific endpoints for use by organizations that require FIPS compliance. (In other words, FIPS is less of an “option” in AWS and more of a “parallel infrastructure”.)

Tag and _all_ free-form fields are basically considered non-confidential in AWS. This is a big contrast to something like GitHub (and many other services), which supplies a functionality specifically for storing sensitive/secret information.

- [Security in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/security.html)

### How Amazon API Gateway Works With IAM

Interesting: Federated identities in Amazon work by assuming roles rather than being a special kind of IAM user. The API Gateway guide, at least, explicitly _discourages_ the use of IAM users in favor of roles (since role credentials are short-lived). This would seem to be an indirect endorsement of using federated identities with AWS rather than IAM users (whenever possible).

(Another side-note: Resource policies are always _inline_. Which kinda makes sense, as the places where resource policies are used - S3 bucket policies, role trust policies, etc. - are generally with objects that are almost always their own special snowflakes.)

API Gateway actions in IAM policies are all `apigateway:` + some HTTP verb.

- `apigateway:GET`
- `apigateway:POST`
- `apigateway:PUT`
- `apigateway:DELETE`
- `apigateway:PATCH`
- `apigateway:*`

These define permitted interactions with API Gateway’s API, _not_ the APIs built using API Gateway. The resources these actions are scoped to are individual APIs or sets of APIs, as defined by the API path expressed as the appropriate ARN. Further restrictions as to _what_ classes of action are allowed are defined using conditions. (Though the documentation is kind of ambiguous here - the text states more-or-less what I just said, but the provided example implies a more flexible model.)

In IAM policies, multiple Condition blocks, or keys within a Condition block, are implicitly ANDed together; however, multiple conditions within a Condition block key are ORed.

REST APIs (but not HTTP or WebSocket APIs) can have resource policies attached to them.

- [How Amazon API Gateway works with IAM](https://docs.aws.amazon.com/apigateway/latest/developerguide/security_iam_service-with-iam.html)

### Using Service-Linked Roles for API Gateway

Service-linked roles cannot be deleted in the IAM console until all related resource have been deleted.

- [Using service-linked roles for API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/using-service-linked-roles.html)
