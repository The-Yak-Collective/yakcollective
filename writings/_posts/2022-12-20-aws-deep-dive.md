---
title: AWS Deep Dive
date: 2022-12-20 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-12-20-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working With WebSocket APIs

- [Amazon API Gateway: Working with WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-websocket-api.html)

### Setting Up Data Transformations for WebSocket APIs in API Gateway

WebSocket API proxy integrations cannot use integration response templates - the backend response is always passed back as-is to the caller. When response templates _are_ used, they are limited to switching on Lambda error messages or HTTP status codes (depending on the integration type).

- [Setting up data transformations for WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-data-transformations.html)

### Working With Binary Media Types for WebSocket APIs in API Gateway

Basically, WebSocket APIs in API Gateway can’t handle raw binary. Any such files need to be converted to/from base64, as appropriate, as the first step in processing.

- [Working with binary media types for WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-develop-binary-media-types.html)

### Invoking a WebSocket API in API Gateway

Sending callback messages from the backend _to_ the client require that those messages be SigV4 signed. Surprisingly, this can be done by calling the corresponding `@connections` URL in API Gateway directly - connections don’t have to be established through API Gateway first!

```
https://${api-id}.execute-api.${region}.amazonaws.com/${stage}/@connections/${connection_id}
```

Given that _any_ client can call this URL, it’s a good thing that SigV4 signing is required!

Messages can be sent to the client at `connection_id` using POST requests, while the client’s current status will be returned when using GET. A DELETE request will disconnect the client.

- [Invoking a WebSocket API](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-how-to-call-websocket-api.html)

### Working With Stages for WebSocket APIs in API Gateway

As with other API types, you cannot specify a Lambda function for use with the WebSockets API using stage variables if that function is in another account.

- [Working with stages for WebSocket APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/websocket-api-stages.html)

### Deploy a WebSocket API in API Gateway

Each API in API Gateway is limited to ten stages.

- [Deploy a WebSocket API in API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-set-up-websocket-deployment.html)
