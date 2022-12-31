---
title: AWS Deep Dive
date: 2022-06-23 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-06-23-aws-deep-dive.html
author: 100007
---

# Deep Dive on Amazon S3 Security and Management

[AWS re:Invent 2018: Deep Dive on Amazon S3 Security and Management (YouTube)](https://youtu.be/x25FSsXrBqU)

## S3 Access Control Mechanisms

By default, S3 buckets are only accessible by the owner

Available access control mechanism:

- IAM - Best when dealing with internal Amazon users/systems. Controls access from the _user’s_ perspective.
- S3 Bucket Policy - Uses the same JSON structure as IAM. Controls access from the _bucket’s_ perspective. Need to be used for cross-account authentication.
- S3 ACLs - XML-based. Can only _add_ access. “Full Control” is used for cross-account access.
- VPC Endpoints - Use a VPC endpoint as a proxy, and then restrict access using VPC policies. Allows bucket _content_ to be exposed externally without exposing the entire bucket.
- Pre-Signed URLs - Basically, special URLs that can perform pre-defined actions. _Anyone who can access this URL can perform these actions._

IAM _authentication_ is handled by the account itself, but _authorization_ is handled on a service-by-service basis.

## S3 Block Public Access

This is a set of security controls that blocks unrestricted (“public”) non-cross-account access, overriding (depending on the use case) existing permissions. There are four controls, each of which can be applied separately:

- _Block_ new public ACLs and objects
- _Remove_ existing public access granted by ACLS
- _Block_ all new public bucket policies
- Block public _and_ cross-account access to public buckets

The last of these is intended to be an intermediate state allowing a bucket to be temporarily locked down while public policies are removed or restricted.

These four policies can be applied in any combination at either the account (which applies to all buckets) or per-bucket level. When applied at the account level, new buckets will automatically inherit these policies. (Note that when new buckets are created on the console these settings are all selected by default, even if these policies have _not_ been applied. These can be thought of as “safe defaults”. _However_, if the policies are not applied at the account level, then buckets created via the API will _not_ be protected by default!)

## How S3 Authorizes a Request

When S3 is checking authorization, it rolls up all applicable policies and then considers them as a single “master” policy. There are (conceptually) three stages to this check:

- User context (has the user been granted explicit access).
- Bucket context (has the bucket owner granted the user authorization to perform a particular action).
- Object context (does the object ACL grant access).

S3 starts by checking for an _explicit_ deny, and if one exists evaluation stops and the action is denied. A check is then made for an explicit _allow_, and if one exists evaluation stops and the action is allowed. If neither an explicit deny or allow are found, then the action/user is _implicitly_ denied.

Interestingly, by default bucket ownership does _not_ grant object ownership. So in a cross-account situation, objects uploaded by one account to a bucket owned by another account are _not_ readable by the bucket owner unless an ACL exists for the object providing that permission. Object-level permissions _cannot_ be changed at the bucket level. (To allow other bucket users to view uploaded objects, either the object owner must either add the users to the object ACL or add a role controlled by the bucket owner that other users can assume.)

## S3 Encryption

Encryption keys can be managed directly in S3, via AWS KMS, using client-managed keys, or entirely client-side.

It sounds like encryption is done using symmetric keys, at least in the KMS case. However, the key itself is encrypted by KMS. The encrypted key is then stored alongside the encrypted object, and handed back to KMS for decryption when the object is retrieved (this creates an additional layer of authorization, as KMS is _also_ checking to see if decryption operations are authorized). I think the idea here is to enable per-object keys but still use a single “source of truth” for decryption authorization.

## Use Cases

It turns out that Capitol One wrote a similar anti-ACL policy before AWS introduced the security features discussed above. One trick they used was to add an explicit “deny all” with the condition that the user was _not_ within Capitol One’s AWS organization.

A good use case here for when to use AssumeRole, but it’s kind of reverse what Amazon was describing: Capitol One’s high-security systems will do an AssumeRole to push lower security data into a segmented low-security system. Doing that means that data being placed into low-security S3 buckets is put there _by the low-security account_ (whose role the high-security account has assumed). This allows the low-security account to then manage access to that data without the high-security account ever needing to interact with or know about downstream object consumers. This also gets Capitol One out of having to manage ACLs _entirely_.

# Become an IAM Policy Master in 60 Minutes or Less

[AWS re:Invent 2018: Become an IAM Policy Master in 60 Minutes or Less (YouTube)](https://youtu.be/YQsK4MtsELU)

## IAM Policy Language

Basic IAM policy structure: “PARC” - Principal, Action, Resource, Condition. This is all led by an initial “effect”, which is allow/deny.

- Principal - the entity with is allowed/denied access.
- Action - the type of access being allowed/denied.
- Resource - what the action is working on.
- Condition - _when_ should the policy be enforced.

I’m guessing that the “default” condition is `*`, since I’ve seen IAM policies without conditions.

A non-standard way to think about policy evaluation: It’s all about matching. (Does the incoming policy, which may include AWS-populated data, match a policy defined by the account? If so, then execute that policy, deny before allow. If not, then just deny.)

## Policy Types & Interactions

It sounds like AWS Organizations are basically just another policy layer on top of (and overriding?) regular accounts. In particular, these policies seem to be more geared towards controlling access to entire services (can a particular account even _use_ S3 or EC2) more than user- or role-level permissioning. These “service control policies” are default deny, just like everything else in AWS, but all new accounts/organizations are provisioned with an explicit “allow everything” service control policy initially.

IAM has the concept of a “permission boundary”, which are defined _maximum_ permission sets _within_ an account.

“STS” in AWS stands for “Security Token Service”.

In general, you need an IAM policy _or_ a resource-based policy to access something within an account. For cross-account access _both_ the IAM and resource-based policies must be present and aligned.

## Policy Use Cases

The recommendation here when using service control policies at the organization level is to blacklist, rather than whitelist, things. That’s kind of reverse from the normal way of doing things, and seems to mostly be motivated by the sheer number of services (and the growth rate of that number) that AWS supports.

When scoping service control policies by region, note that a handful of services (and actions within some otherwise normal services) that are _globally_ scoped. That means that _denying_ a region will not always have the effect you want! (I assume this means we should deny globally and then allow in specific regions in this case, opposite of the previous advice.)

You can do some cool things with IAM and service control policies, like _requiring_ that developer-created roles include a permission boundary or region.

Policies actually support some limited variables: For example, `${aws:PrincipalTag/project}` let’s you reference user (“principal”) tags within a policy condition. This lets you, for example, require that developers always tag resources they create with a pre-assigned (role?) tag (you can also restrict the ability of developers to _control_ resources that don’t share their tag). This sort of generality comes in handy if you have a lot of teams that have the _same_ permission structure but need to be siloed from each other - write _one_ policy (or set of policies), and then tag the associated users/groups/roles to apply that policy in an _identical but disjoint_ fashion.

