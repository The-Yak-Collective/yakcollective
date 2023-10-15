---
title: AWS Deep Dive
date: 2022-10-15 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-15-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Enable Request Validation in API Gateway

Incoming requests that fail API Gateway validation (if configured) result in the following:

- The integration request and later steps are _not_ performed.
- The API Gateway immediately responds with a 400.
- The validation failure is pushed to the configured CloudWatch log.

API Gateway validation consists of ensuring that all expected parameters are present and (if applicable/configured) that any request payload conforms to the “JSON schema” supplied when specifying the request body in the corresponding method request. Validation is activated by specifying a “validator”, which is just a (defined) collection of parameters that controls whether validation is performed on the request body, other request parameters, or both (an absent validator seems to be equivalent to specifying no validation on either parameter set). It’s a little unclear what advantage the level of abstraction provided by the “validator” object provides, since there are only two valid sub-parameters.

A “default” validator can be set at the level of the entire API, in which case it will be applied to all defined methods (unless that method specifies an alternate, overriding, validator).

- [Enable request validation in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-method-request-validation.html)

### API Gateway: Setting Up Data Transformations for REST APIs

Mapping templates (method request -\> integration request and integration response -\> method response) are Velocity Template Language (VTL) scripts; individual data elements from the input are specified using JSONPath. VTL itself looks fairly straightforward, and is reminiscent of both Handlebars and Liquid.

VTL transformations can be applied to either the body payload or to non-body parameters (headers, query parameters, or response codes). It is a little unclear how the API Gateway determines whether a mapping template is operating over a request or response payload vs. other HTTP parameters, though it looks from the documentation that different parts of the HTTP request/response (headers, body, etc.) are set in different parts of the API Gateway console/API.

Mappings are defined in the final processing step (“integration request” for incoming requests, or “method response” for outgoing responses). Different body mappings can be defined for different content types: For incoming (method) requests the API Gateway will inspect the `Content-Type` header, while for outgoing (integration) responses the `Accept` header will be used; `application/json` is used as the default if an appropriate header is missing. Mappings can be used for some content types but not others, but if this is done then an empty mapping (and appropriate pass-through behavior) _must_ be supplied for any content types that should be transparently passed through.

Parameter names (GET variables, header names, and JSON parameters) must match the `^[a-zA-Z0-9._$-]+$` regexp. While body mappings are defined explicitly, (JSON) body parameters can be referenced in non-body mappings using JSONPath expressions (in the `method.request.body` or `integration.response.body` namespace).

Apparently the standard `$input.params(i)` variables are vulnerable to JSON path injection. For whatever reason Amazon _doesn’t_ fix this automatically, but rather recommends that returned values be processed by `$util.escapeJavaScript()` before use instead (I guess that fixing this proactively must break critical functionality for some _really_ big customers…). (Except… Apparently `$util.escapeJavaScript()` produces invalid JSON when the input contains single quotes, so the construct `$util.escapeJavaScript('$').replaceAll("\\'","'")` needs to be used instead. WTF?)

For all `$input` functions, the `$` parameter represents the root of the request body JSON (though it looks like this can be safely dropped so long as you’re not referring to the entire object itself).

- [Setting up data transformations for REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/rest-api-data-transformations.html)
- [Apache Velocity Engine - User Guide](https://velocity.apache.org/engine/2.3/user-guide.html)
- [Handlebars - Introduction](https://handlebarsjs.com/guide/)
- [Liquid template language](https://shopify.github.io/liquid/)
