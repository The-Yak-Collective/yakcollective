---
title: AWS Deep Dive
date: 2022-10-11 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-11-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-10-11

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Setting up REST API Integrations (Continued…)

Like Lambda proxying, HTTP endpoint proxying requires the use of _both_ a greedy `{proxy+}` path parameter and the virtual `ANY` method. Proxying then works exactly as you’d expect, such that

```
GET https://$AWS_API_GATEWAY_URL/{proxy+}
```

is mapped to

```
GET https://$HTTP_ENDPOINT_URL/{proxy+}
```

The API Gateway can also be used to create controlled integrations with otherwise private systems within a VPC via a network load balancer in the VPC (used to route API calls to specific VPC resources) accessed via a VPCLink connection. Essentially, the network load balancer + VPCLink + API Gateway chain creates a “virtual DMZ” between the internet at large and the internal VPC resources. API calls are made through the VPCLink to specific ports exposed on the network load balancer, where each port represents a particular VPC resource.

Unlike the case with authorization services, when attaching an API Gateway to a VPC all associated services must be in the same AWS account. Note that VPCLink creation is handled via the API Gateway (though the user doing the setup needs to have the permissions necessary to set up - but not necessarily _use_ - the VPCLink), though the network load balancer must be configured separately. Be aware that a VPCLink is a type of VPC endpoint, and a VPC network load balancer can only be associated with a single endpoint at a given time.

One interesting strategy is to use “stage variables” defined in the API Gateway to determine which VPCLink is being connected to (a similar strategy can presumably be used for other API settings). These variables are referred to using the `${stageVariables.VARIABLE_NAME}` notation; their use let’s APIs defined in a given gateway be redefined (in a limited sense) by simply updating these variables. One use case: Swapping a production API to a new backend without having to rebuild the entire API stack defined in the API Gateway.

- [2022-10-10 - AWS Deep Dive (Setting up REST API Integrations, Part 1)](https://cardboard-iguana.com/log/2022-10-10-aws-deep-dive.html)
- [Amazon API Gateway: Setting up REST API Integrations](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-integration-settings.html)
