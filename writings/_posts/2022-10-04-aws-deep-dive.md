---
title: AWS Deep Dive
date: 2022-10-04 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-04-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-10-04

# Amazon API Gateway

Notes about the Amazon API Gateway continue.

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Creating a REST API in Amazon API Gateway (Continued…)

In the API Gateway documentation, “request parameters” always means URL parameters (either GET variables or dynamic portions of the URL) or HTTP headers, while “request body” refers to JSON blobs that compose the, well, request body.

For non-GET requests, JSON payloads can be defined as “models” using the JSON Schema specification. These are specified with the AWS CLI using the `--request-models` flag with the JSON blob `{"media/type":"modelName"}` (for example, `{"application/json":"apiInputModel"}`).

Dynamic resource substrings can be specified using the `{proxy+}` notation (“proxy” can actually be any word). This functions like a wildcard, so `/foo/{proxy+}` functions like `/foo/*`. Proxy resources are passed as full strings, and can contain additional URL sub-paths (for example, `/foo/bar/baz/1000` will be passed as `bar/baz/1000`); it’s the backend’s responsibility to decompose the proxy string and respond appropriately. Proxy strings can’t have children (so `/foo/{proxy+}/{itemId}` is _not_ permitted), but can have siblings (if `/foo/bar` is defined, then `{proxy+}` will _not_ match `bar` and its children).

Request parameter specs:

- method.request.path.foo - path parameter “foo”
- method.request.querystring.bar - GET variable “bar”
- method.request.header.baz - HTTP header “baz”

Setting a request parameter to “true” when defining it marks it as required, while using “false” marks it as optional. Example AWS CLI call:

```
aws apigateway put-method \
--rest-api-id vaz7da96z6 \
--resource-id 6sxz2j \
--http-method GET \
--authorization-type "NONE" \
--region us-west-2 \
--request-parameters '{
"method.request.path.foo": true,
"method.request.querystring.bar": false,
"method.request.header.baz": false
}'
```

If a request model is supplied, then a “validator” can also be set up in the API Gateway and then applied to incoming parameters, though only parameters marked as required can be validated.

API Gateway supports the DELETE, GET, HEAD, OPTIONS, PATCH, POST, and PUT methods, as well as the special ANY method which will pass _all_ methods to the same backend handler (like `{proxy+}`, in this case the backend becomes responsible for decomposing and properly handling the different verbs).

The API Gateway can handle _some_ authorization methods as well:

- `NONE` - no authorization
- `AWS_IAM` - use IAM
- `CUSTOM` - use a Lambda function for authorization
- `COGNITO_USER_POOLS` - use Amazon Cognito

IAM authentication uses Sigv4; cross-account access to call APIs can only be granted indirectly via AssumerRole.

Method responses can either be pre-configured mappings from the backend to the client (HTTP status code, response parameters, and a response model), or just directly proxy the backend response to the client. Defined method responses are chosen by matching the HTTP status code returned by the backend, with 500 returned for any unmapped backend responses. Note that response parameters are only necessary if the API Gateway is to map the backend responses - if not defined, then the backend response will simply be proxied. Response models are only necessary for automatic SDK generation.

- [2022-10-02 - AWS Deep Dive (Creating a REST API in Amazon API Gateway, Part 1)](https://cardboard-iguana.com/log/2022-10-02-aws-deep-dive.html)
- [JSON Schema](https://datatracker.ietf.org/doc/html/draft-zyp-json-schema-04)
- [Creating a REST API in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-create-api.html)

### Controlling and Managing Access to a REST API in API Gateway

Resource policies can be attached to APIs defined in the API Gateway in a similar fashion to S3.

(To be continued…)

- [Controlling and managing access to a REST API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-control-access-to-api.html)
