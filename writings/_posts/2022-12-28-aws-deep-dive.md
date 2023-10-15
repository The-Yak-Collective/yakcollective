---
title: AWS Deep Dive
date: 2022-12-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-12-28-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Security

- [Security in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/security.html)

### Monitoring API Gateway API configuration with AWS Config

The AWS Config service allows changes to API Gateway configuration (both API- and stage-related) to be tracked and optionally alerted on. It’s worth noting that AWS Config seems to pick up on configuration changes when they’re _made_, but in API Gateway some changes only take effect _after_ the API has been redeployed. In these cases, AWS Config can show a change as having been made (which it was), but the API may still be operating under the previous settings (if the change required a redeployment to become active).

- [Monitoring API Gateway API configuration with AWS Config](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-config.html)

### Infrastructure Security in Amazon API Gateway

STS (an acronym that shows up frequently when talking about assumable roles) stands for “Security Token Service”.

- [Infrastructure security in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/infrastructure-security.html)

## Tagging

Tags in AWS are key/value pairs - kind of an intermediate step between the simple string-only tagging found in many apps and full hierarchical tagging (key/value tagging is isomorphic to hierarchical tagging that’s been restricted to only two levels).

Tags without assigned values are interpreted as having a value of the empty string.

- [Tagging your API Gateway Resources](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-tagging.html)

### API Gateway resources that can be tagged

Tags are basically at the level of an “API” (or stage) in API Gateway - they cannot be applied to individual _methods_ (or other components) within that API, though queries on sub-API components will return the tag of the parent API or stage in some cases.

In the case of stages, tags can either be set directly or inherited from the parent API. If tags with the same key but different values are assigned to both the API and the stage, the more specific tag (i.e., the tag for the stage) will take precedence.

As you might expect from this, only one tag with a given key can be applied to a particular resource in API Gateway. There is also a limit of 50 tags per resource (however, AWS-reserved tags, which all begin with `aws:`, don’t count against this limit).

- [API Gateway resources that can be tagged](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-tagging-supported-resources.html)

### Using Tags to Control Access to API Gateway Resources

Tags can limit access to both resources that currently exist (resource tags) and resources that a user tries to create (request tags).

(Request tags are basically resource tags that are being applied to resources that are being created. You’d think that it would be easiest to just think of these as resource tags as well, but IAM policies distinguish between these tag types: Resource tags are referenced using `aws:ResourceTag/$TAG_NAME` condition keys, while request tags are referenced using `aws:RequestTag/$TAG_NAME` condition keys.)

- [Using tags to control access to API Gateway resources](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-tagging-iam-policy.html)

## Quotas and Important Notes

In practice, ARNs are limited to a total of 1600 bytes (ASCII characters), as IAM policies and quotas (and other things?) will take errors when attempting to operate on longer values.

API Gateway quotas are surprisingly low, generally just a few hundred requests per second across a given API. Accounts are capped at 10,000 requests per second across _all_ APIs, though this can be increased. This would seem to make API Gateway unsuitable for extremely popular APIs, unless such an API was sharded across multiple API Gateway APIs and/or AWS accounts (in which case a custom domain would be required to “stitch” the full API back together).

- [Amazon API Gateway Quotas and Important Notes](https://docs.aws.amazon.com/apigateway/latest/developerguide/limits.html)

### Amazon API Gateway important notes

APIs cannot use `/ping` and `/sping` method endpoints, as these are reserved for internal health checks. Or, rather, apparently you _can_ use these method endpoints, but they won’t work because the internal mapping will take precedence.

Rest APIs in API Gateway apparently don’t handle `|` and `;` characters in query strings very gracefully - the former must be percent-encoded, while the latter will always split the query data.

Apparently, VPC link information needs to be removed _before_ associated methods are deleted, as otherwise the VPC link will still be registered as in-use!

Also, API Gateway apparently doesn’t play nice with NGINX.

If I read the header restrictions for API Gateway correctly, I’m not sure it’s ever vulnerable to HTTP request smuggling, as the `Transfer-Encoding` header is never passed through, and will sometimes even generate an exception when supplied.

API Gateway only inspects the _first_ media type in the `Accept` header; since the application can’t always control the order the browser will send these headers in, this means that you basically need to include all possible MIME types that may be associated with a request when configuring the `binaryMediaTypes` parameter, even if the backend only responds with a limited number of types.

- [Amazon API Gateway important notes](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-known-issues.html)
- [Percent-encoding (MDN)](https://developer.mozilla.org/en-US/docs/Glossary/percent-encoding)
- [HTTP request smuggling (Wikipedia)](https://en.wikipedia.org/wiki/HTTP_request_smuggling)
