---
title: AWS Deep Dive
date: 2022-11-17 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-17-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Configuring Mutual TLS Authentication for a REST API in API Gateway

When using mutual TLS configuration, API Gateway forwards the client certificates through to the relevant Lambda authorizer and/or other backend functions. Since mutual TLS requires the server to have a valid (custom) certificate, the default API Gateway endpoint needs to be disabled in this mode. _Regional_ custom domains must be used, and these endpoints _must_ be public (no mutual TLS with private APIs).

Client certificates are must be signed by an `ownershipVerificationCertificate` help in the AWS Certificate Manager (this certificate _cannot_ be used for the domain), and a PEM file containing the client certificates and their _complete_ chain of trust must be uploaded S3 as a “trust store”. S3 versioning can be used to enable easy rollbacks; changing the current S3 version requires an API redployment.

While API Gateway checks to make sure that client certificates are _valid_, it lacks the ability to check these against a revocation list. However, a Lambda authorizer can be used to check for revocation.

- [Configuring mutual TLS authentication for a REST API](https://docs.aws.amazon.com/apigateway/latest/developerguide/rest-api-mutual-tls.html)

### Generate and Configure an SSL Certificate for Backend Authentication with API Gateway

API Gateway supports mutual TLS both as a server (see the previous section) _and_ as a client (when talking to API backend services). However, API Gateway generates a _self-signed_ certificate in the latter case, so backend services will need to verify the connection using an explicit allow list.

API Gateway client certificates are per API and per stage; rotating certificates requires an API redployment.

- [Generate and configure an SSL certificate for backend authentication](https://docs.aws.amazon.com/apigateway/latest/developerguide/getting-started-client-side-ssl-authentication.html)

### Using AWS WAF to Protect API Gateway

AWS WAF rules are evaluated before anything else, including IAM rules. It’s thus not possible to use IAM policies to “punch holes” in the WAF. API Gateway must be used with _regional_ WAF rules (called “web ACLs” by Amazon). Web ACLs are per API and per stage.

- [Using AWS WAF to protect your APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-control-access-aws-waf.html)

### Throttle API Requests for Better API Gateway Throughput

API throttling is per API per stage per region, and _optionally_ per resource/method and per API key (really, the associated usage plan).

- [Throttle API requests for better throughput](https://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-request-throttling.html)
