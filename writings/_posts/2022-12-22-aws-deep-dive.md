---
title: AWS Deep Dive
date: 2022-12-22 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-12-22-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working With WebSocket APIs

- [Amazon API Gateway: Working with WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html)

### Setting Up Custom Domain Names for WebSocket APIs in API Gateway

WebSocket APIs only support TLS 1.2 (what, no TLS 1.3?) and _cannot_ share a domain name with non-WebSocket APIs. The domain name used to call an API is available as `$context.domainName`. Certificates must be provisioned by or imported into ACM for in the appropriate region.

APIs can be mapped either to the domain itself (in which case only a single API is supported) or to a particular path from that domain.

- [Setting up custom domain names for WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-custom-domain-names.html)

### Protecting Your WebSocket API in API Gateway

Throttling hierarchy: AWS \> account and region \> route and stage.

- [Protecting your WebSocket API](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-protect.html)
