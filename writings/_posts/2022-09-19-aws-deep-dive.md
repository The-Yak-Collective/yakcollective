---
title: AWS Deep Dive
date: 2022-09-19 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-09-19-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-09-19

The AWS deep dive reading notes return!

# AWS IAM Policies in a Nutshell

IAM policy statements can include an `Sid` value (different than the policy-level `Id`). This is only required by a few services (SQS and SNS). It seems like it’s probably safe to just set both the `Id` and the `Sid` to some UUIDv4 value (though the two should _probably_ use different UUIDs).

(The reason there’s both an `Sid` and an `Id` is that the policy `Statement` can point _either_ to a single object _or_ an array of objects. `Sid` is redundant in the first case, but uniquely identifies each policy statement object in the second case.)

Many (most?) IAM policy properties accept wild-carding. An `Action` of `s3:Get*` is equivalent to writing `s3:GetObject`, `s3:GetBucket`, …

(The “?” string can also be used as a single-character wildcard.)

There’s also “policy variables” which can be used anywhere a wildcard can be. These are things like `aws:username`, and when used they’re referenced as `${aws:username}`.

Statement properties (`Principal`, `Action`, and `Resource`) generally accept either a string or an array of strings.

The IAM policy statement `Principal` isn’t needed for policies attached to users, groups, and roles. In all of these cases, the `Principal` defaults to the object the policy is attached to (makes sense). Thus, `Principal` is primarily used only for policies attached to resources like S3 buckets and SQS queues.

(Policies attached to resources _sometimes_ don’t need to include a `Resource` object in the policy statement. But sometimes they do. For example, “permissions policies” attached to roles - see below - don’t need a `Resource`, but policies attached to S3 buckets _do_ need a `Resource`.)

Group ARNs are _not_ allowed to be principals.

Roles require _two_ policies to be attached - a “permissions policy” (which specifies what the role can do) and a “trust policy” (which specifies who can assume the role). In a sense, a role functions as both an actor (via the “permissions policy”) and a resource (via the “trust policy”).

Trust policies are where the `sts:AssumeRole` action gets used.

The ARN format:

```
arn:aws:[service]:[region]:[account]:[resourceType]/[resourcePath]
```

The “service”, “region”, and “account” portions of an ARN can be collapsed if not relevant. Thus `arn:aws:s3:::bucket-name/*` is equivalent to `arn:aws:s3:*:*:bucket-name/*`.

The statement `Condition` property is an object that contains one or more conditions of the following form:

```
"conditionOperator": {
"conditionKey": "conditionValue"
}
```

For example:

```
"DateGreaterThan": {
"aws:CurrentTime": "2022-09-19T00:00:00Z"
}
```

Many (all?) available condition keys are also policy variables.

Annoyingly, not every action supports every condition key.

- [AWS IAM Policies in a Nutshell](https://start.jcolemorrison.com/aws-iam-policies-in-a-nutshell/)
- [IAM policy elements: Variables and tags](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_variables.html)
- [Actions, resources, and condition keys for AWS services](https://docs.aws.amazon.com/service-authorization/latest/reference/reference_policies_actions-resources-contextkeys.html)
- [IAM JSON policy elements: Condition operators](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html)
- [AWS global condition context keys](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_condition-keys.html)
