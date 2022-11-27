---
title: AWS Deep Dive
date: 2022-10-02 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-02-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-10-02

# Amazon API Gateway

More notes about the Amazon API Gateway. (In the interest of time I’m skipping the “Tutorials and Workshops” section of Amazon’s documentation, however.)

## Getting Started

API Gateway automatically integrates with Lambda, showing available functions when creating new APIs. Handy!

API routes (URL endpoints) by default match the name of the corresponding Lambda function, though this can be changed.

Creating a Lambda function automatically creates an associated CloudWatch log group and an IAM role for execution. So, this is a reason for using something like CloudFormation to automate things, though you’d think that AWS would just ask the user if these objects should be deleted when the function is removed.

- [Getting started with API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/getting-started.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Creating a REST API in Amazon API Gateway

Backend replies are expected to happen synchronously relative to the corresponding frontend requests with the API Gateway’s REST API feature.

The REST API model: Resources (logical API object collections) \> Entities (API object paths) \> Method Requests (HTTP verbs + expected request bodies) \> Integrations (mappings to backend URIs + necessary transforms) \> Integration Responses (per-HTTP response code behavior + any necessary transformations for backend response) \> Method Responses (per-HTTP response code behavior for returned integration responses). Separately, a “Documentation Part” can be added for internal/external documentation.

It’s remains unclear to me why integration and method response parts are handled in separate parts of the chain.

Types of API endpoints:

- Edge-Optimized (using CloudFront; use capitalized HTTP header names)
- Regional (per-region, though they can be routed to dynamically using Route 53; pass HTTP headers as-is with some exceptions)
- Private (can only be accessed within a VPC; pass HTTP headers as-is)

Edge-optimized endpoints are the default; the other options allow either less expensive / more responsive implementations when global coverage isn’t necessary (regional) or when an API is purely internal (private). API endpoint types can be updated, but only within a (somewhat obvious) chain: Edge-Optimized \<-\> Regional \<-\> Private.

The distinction between “resources” and “entities” within API gateway is somewhat arbitrary - really what you’re doing is building a tree of endpoints that map to various API paths. Dynamic path elements can be specified as {dynamicPathElementName}; these need to be references as requestParameters within the API as method.request.path.dynamicPathElementName (and must be explicitly marked as required).

OpenAPI JSON objects can also be directly imported to build out APIs.

The API Gateway will throw an exception for calls that use invalid paths, without ever passing the request to the corresponding backend.

A “catch all” response can be configured in the API Gateway for when the API backend doesn’t respond in an expected manner. Interestingly, Amazon _recommends_ configuring the API Gateway to throw a 500 in these cases.

The API Gateway also supports a special “proxy” resource that allows API paths to be built (and changed) dynamically. Proxy resources are specified using {proxy+} and function like `*`.

(To be continued…)

- [Creating a REST API in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-create-api.html)
