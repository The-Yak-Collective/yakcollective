---
title: AWS Deep Dive
date: 2022-10-31 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-10-31-aws-deep-dive.html
author: 100007
---

# Amazon API Gateway

Continued notes about the Amazon API Gateway.

- [Amazon API Gateway: Developer Guide](https://docs.aws.amazon.com/apigateway/latest/developerguide/welcome.html)

## Working with REST APIs

- [Amazon API Gateway: Working with REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/apigateway-rest-api.html)

### Deploying a REST API in Amazon API Gateway (Continued)

Stage variables can be referenced directly as `stageVariables.VARIABLE_NAME` in request and response header parameter mappings, but must be referenced as `${stageVariables.VARIABLE_NAME}` everywhere else (including mapping _templates_). Interestingly, stage variables cannot be used to construct ARNs referencing Lambda functions in other accounts.

API Gateway also has the concept of a “canary release”, which allows a new version of an API to be tested using only a small percentage of the API traffic. The new version can be an iteration of the existing deployment attached to a stage (in which case the API cache is shared) or a different deployment entirely (in which case the canary uses its own cache). Canary logs wind up in _both_ the normal API Gateway CloudWatch log group _and_ their own prefix.

Canary deployments are triggered by adding the appropriate canary settings/variables (they seem to be called different things depending on the context) to an existing stage. (Similarly, a canary deployment is disabled by simply removing these variables.) It’s implied in the instructions that canary deployments do _not_ use the same WAF as the main API deployment.

Things that require an API to be redeployed if updated:

- API keys
- Authorizers
- Documentation
- Gateway responses
- Integrations
- Methods
- Models
- Request validators
- REST API definitions
- Any other “resources”
- VPC links

Things that _don’t_ require an API redployment when updated:

- Account information
- Deployment information
- Domain name changes
- Base path changes
- Stage changes
- Usage restrictions

And that’s about it for REST API deployments.

- [2022-10-26 - AWS Deep Dive (Deploying a REST API in Amazon API Gateway, Part 1)](https://cardboard-iguana.com/log/2022-10-26-aws-deep-dive.html)
- [Deploying a REST API in Amazon API Gateway](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-deploy-api.html)

### Setting Up Custom Domain Names for REST APIs in API Gateway

Custom domains can only be used by public APIs. Surprisingly, it seems that API Gateway’s TLS support caps out at v1.2.

TLS certificates can either be provisioned on a bring-your-own-certificate basis, or via a service called AWS Certificate Manager.

API Gateway _does_ support wildcard domains, and provides `$context.domainName` and `$context.domainPrefix` variables to allow per-subdomain API behavior. This means that a wildcard domain like `*.example.com` can have a default behavior defined, but then `a.example.com` and `d.example.com` can both have custom behavior bypassing these defaults.

To be continued…

- [Setting up custom domain names for REST APIs](https://docs.aws.amazon.com/apigateway/latest/developerguide/how-to-custom-domains.html)
