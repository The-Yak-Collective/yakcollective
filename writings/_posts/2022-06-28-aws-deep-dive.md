---
title: AWS Deep Dive
date: 2022-06-28 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-06-28-aws-deep-dive.html
author: 100007
---

# AWS Deep Dive

**author:** Nathan Acks  
**date:** 2022-06-28

# Amazon S3: Bucket Policies and User Policies

This is an exercise in setting up cross-account bucket permissions.

The idea here is for Account A to grant Account B access to some resource (in this case, an S3 bucket), and then for Account B to delegate access to users within that account.

For a user to access a cross-account resource, they must have permission to do so from _both_ the resource owner (Account A) and their own account (Account B). _This is true even if Account B as a whole does not have access to the resources the user has been granted permission to._

I eventually had to set up the AWS CLI on my Raspberry Pi, as iSH seems to be deeply broken right now (though everything seems to be fixed in git).

- [Amazon Simple Storage Service (S3) - Bucket policies and user policies: Bucket owner granting cross-account bucket permissions](https://docs.aws.amazon.com/AmazonS3/latest/dev/example-walkthroughs-managing-access-example2.html)
- [Use a Raspberry Pi 4B as an iPad Pro Hacking Accessory](https://cardboard-iguana.com/notes/use-a-raspberry-pi-4b-as-an-ipad-pro-hacking-accessory.html)
- [iSH](http://ish.app/)
- [ish-app / ish](https://github.com/ish-app/ish)

# Using IAM Roles

Next up is reading through the section of the AWS IAM documentation about roles. I’m going to continue to use bullet-point lists here for notes.

## Using IAM Roles

Interesting limitations: `RoleName` attributes are limited to 64 characters, but can have an prepended `Path` of up to 512 _additional_ characters. However, roles where the length of `Path` + `RoleName` is greater than 64 characters cant’s be switched to via the Console - they’re essentially API-only. This is rooted in the combined `Path` + `RoleName` value being stored as a browser cookie.

How long you can assume a role for varies a lot, and can be controlled via URL construction or API call _up to_ the maximum session duration defined for that role (or to 12 hours for roles assumed via a URL, which happens to be the maximum value for the maximum session duration).

There’s a hard limit of 1 hour, however, when you chain roles together (assuming one, and then using that role to assume another).

If you try to assume a role for longer than the maximum duration allowed in a given context, the operation will fail. Which is unfortunate, as that means that before assuming a role on behalf of a user any process would need to call `aws iam get-role` / the `GetRole` API if the intention is to assume the role for as long as possible.

Role time limits apply only to users - AWS services and applications running on EC2 instances are exempt.

- [Using IAM roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use.html)

## Granting a User Permissions to Switch Roles

As noted above, using cross-account roles (or services) requires the cooperation of both accounts: The account being granted permission to use the role must still _explicitly_ make that role (or service) available to its users.

Root users cannot switch roles.

Roles that require an `ExternalId` can only be accessed over the API.

Switching roles using the admin console does not appear to allow for role chaining.

Successful `AssumeRole` events are tracked by CloudTrail.

- [Granting a User Permissions to Switch Roles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_permissions-to-switch.html)

## Granting a User Permissions to Pass a Role to an AWS Service

`PassRole` cannot be used with cross-account roles.

Three things are required for a user to pass a role to a service: (1) The role itself, (2) a “trust policy” attached to the role that allows the service in question to call `sts:AssumeRole`, and (3) an IAM policy attached to the user passing the role that allows `iam:PassRole` for the role resource ARN.

The user passing a role doesn’t need to have access to that role themselves - they just need permission to pass it.

Role names cannot be changed. But surprisingly, role `Path` parameters _can_ be changed.

- [Granting a User Permissions to Pass a Role to an AWS Service](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_passrole.html)
- [Switching to a Role (Console)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-console.html)

## Switching to an IAM Role (AWS CLI)

You can create a profile for the AWS CLI that automatically assumes a role by specifying two parameters in the associated `profile` block: `role_arn` (obviously the ARN of the role to be assumed) and `source_profile` (the name of an _existing_ profile that has permission to assume `role_arn`). When the AWS CLI is being used on an EC2 instance that has an existing role, `credential_source = Ec2InstanceMetadata` needs to be used instead of `source_profile`.

The requirements to allow a service to assume a role are similar to those to allow a user to pass a role: (1) The role itself, (2) a “trust policy” attached to the role that allows the role that allows the role attached to the service (see next requirement) to call `sts:AssumeRole`, and (3) an role attached to the service itself that allows it to call `sts:AssumeRole` for the first role resource ARN. This is again the pattern where AWS requires that trust relationships be bidirectional.

- [Switching to an IAM Role (AWS CLI)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-cli.html)

## Switching to an IAM Role (AWS API)

When calling the `AssumeRole` API, you can pass in a JSON `Policy` or up to 10 ARNs for pre-defined policies (using `PolicyArns`). The session that is returned will then have the _intersection_ of the permissions of the role being assumed and the provided policies (so these can be thought of as additional limits). This mostly seems to be for when credentials need to be handed off to another user or service.

- [Switching to an IAM Role (AWS API)](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-api.html)

## Using an IAM Role to Grant Permissions to Applications Running on Amazon EC2 Instances

Applications that run on an EC2 instance automatically inherit the role assigned to that instance.

The role assigned to an EC2 instance is defined in the “instance profile”.

EC2 is just a service, so the requirements for EC2 instances to use roles (and for developers to assign roles to EC2 instances) are identical to those for a user who wishes to pass a role to a (generic) service.

That said, allowing an EC2 instance to use a role as part of its “instance profile” does require that the role assigned to the “instance profile” _also_ has a trust policy specifying that EC2 is allowed to call `sts:AssumeRole`.

- [Using an IAM Role to Grant Permissions to Applications Running on Amazon EC2 Instances](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html)

## Using Instance Profiles

Instance profiles and roles are linked in the management console; instance profiles will be automatically created and deleted as needed, and are never directly exposed.

Instance profiles created using the API can also be managed in the console _if and only if_ they have they same name as they associated role.

Tags can _only_ be added to instance profiles using the API.

Changes to instance profiles are not applied instantly, but are rather subject to _eventual consistency_.

- [Using Instance Profiles](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2_instance-profiles.html)

## Revoking IAM Role Temporary Security Credentials

Temporary credentials associated with a role can be revoked before a given point in time. They _cannot_ be revoked per-user.

Revocation is handled by attaching an inline policy to the role that denies all actions before the specified point in time (“now”).

The inline policy will be refreshed automatically with a new point in time denial timestamp if sessions are revoked again at a later time.

AWS CLI users who have their credentials revoked in this way will either need to wait until their session would have expired (which could be up the 12 hours, depending on the role configuration) or manually delete the AWS CLI credential cache (~/.aws/cli/cache).

- [Revoking IAM Role Temporary Security Credentials](https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_revoke-sessions.html)
