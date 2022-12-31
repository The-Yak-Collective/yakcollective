---
title: AWS Deep Dive
date: 2022-10-26 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-26-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Configuring a REST API using OpenAPI with Amazon API Gateway

Merging or overwriting an API with a new Open API definition file is an “idempotent” operation, in that a failure part-way through will result in only those API definitions that have been successfully processed being merged or overwritten, with the remaining APIs in their original state.

If an OpenAPI definition file contains multiple `basePath` definitions, API Gateway will use the first one (unless it has been instructed to ignore this property entirely). Ignoring the `basePath` property is the default; it’s also possible to “prepend” the `basePath` (which has the behavior you’d expect) or “split” it (which has the effect of lopping off the first component of the `basePath`).

OpenAPI definition files can also be exported from the API Gateway, but only if the API uses JSON request bodies and models.

- [Configuring a REST API using OpenAPI](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-import-api.html)

### Deploying a REST API in Amazon API Gateway

It’s possible to map multiple API stages to a single custom domain, but doing so requires mapping the stage names to different `basePath` properties (though in most cases I imagine that this mapping will be trivia - `v1` -\> `v1`, etc.).

API Gateway makes a distinction however between “stages” (where/how an API is accessed) and “deployments” (essentially a snapshot of the API). APIs are always accessed through a stage, which in turn always route requests to a particular deployment. Stages also control environment variables available to API methods and a number of settings related to caching, logging, and throttling.

Interestingly, metrics associated with individual API methods incur a charge, but aggregated metrics at the API or stage level do _not_.

(To be continued…)

- [Deploying a REST API in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-deploy-api.html)
