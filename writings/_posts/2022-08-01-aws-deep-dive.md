---
title: AWS Deep Dive
date: 2022-08-01 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-08-01-aws-deep-dive.html
author: 100007
---

Finally getting back to the “AWS Cloud Practitioner Essentials” course! Today I’ll be covering the “Storage and Databases” module.

- [AWS Cloud Practitioner Essentials](https://www.aws.training/learningobject/curriculum?id=27076)

# EBS

- Instance Store Volumes - storage attached to the “physical” EC2 hardware. This storage is as ephemeral as an EC2 instance, as when an EC2 instance is restarted it may be spun up on a different VM.
- Elastic Block Store - EC2-independent block storage. Think of it like an external hard drive.

EBS volumes support snapshotting. Snapshots are _incremental_ backups.

EBS volumes can be up to 16 TB in size, and come in SSD and HDD flavors. They are limited to a single availability zone (data center).

# S3

The maximum S3 object size is 5 TB. There are _no_ limits to total bucket size.

Notable S3 tiers:

- Standard Tier - 99.999999999% availability; all data is stored within _at least_ three availability zones. Can be used to host static websites.
- Infrequent Access (IA) - data that is infrequently accessed but cannot experience delays _when_ accessed (think backups). It has a lower storage price and higher retrieval price than the standard tier (but the same availability).
- One Zone Infrequent Access - Like the IA tier, but only stores data in a single availability zones. This makes it cheaper but less durable.
- Intelligent Tiering - Uses analytics to dynamically move objects between the standard and IA tiers.
- Glacier - data that is infrequently accessed and _doesn’t_ require quick access. Can be set up as a WORM drive, or have specific retention periods applied. (Note that these policies _cannot_ be changed once applied.)
- Glacier Deep Archive - Cheaper than Glacier, but data can take up to 12 hours to become available.

Data can either be uploaded directly to Glacier, or moved automatically using lifecycle policies.

Objects in S3 have three components: data, metadata, and key (name). Just like a normal filesystem. Unlike normal filesystems, however, all S3 objects are resolvable to normal (public, if desired) URLs.

S3 works best for write-once, read-many applications.

# EFS

Elastic Filesystem is a “managed” filesystem - think something like NFS, or a SAN.

Like most Amazon services, EFS can autoscale with load and has a variety of automation options (automatic snapshots, etc.).

EFS mounts as a normal Linux filesystem, and is a region-level resource (so, it works across data centers, but you can’t have a global EFS).

Files stored in EFS can be written to at the block level, just like files in local storage.

Like S3, data stored in EFS is replicated across multiple availability zones.

The AWS Direct Connect client allows for EFS deployments to be accessed by on-prem systems.

# RDS

Amazon’s “Relational Database Service” supports most common DBs:

- MySQL/MariaDB
- PostgrSQL
- MS SQL Server
- Oracle SQL

RDS abstracts the underlying database _server_, so it’s a bit like Google App Engine, but for DBs. Patching, backups, redundancy, etc. can all be configured in RDS without having to deal with the low-level differences in these operations between different DB flavors.

Amazon also provides a “lift and shift” service to aid migration from on-prem DBs to EC2-backed “RDMS” (“Relational Database Management Service”) systems. These support the same databases as RDS, but function in a more traditional, server-centric fashion.

Aurora is an in-house database developed by Amazon for high availability scenarios. It supports up to 15 replicase across up to 3 availability zones, and can be configured in MySQL or PostgreSQL compatibility mode. Aurora is only available on RDS (it _cannot_ be deployed on a managed server).

# DynamoDB

DynamoDB is a serverless NoSQL database. Scaling and redundancy is handled automatically.

NoSQL systems work best when searching through a large number of objects in a single data store, while relational databases are better at, well, relating (simpler) objects _across_ data stores.

Basically, NoSQL systems work best when dealing with data structured as a lookup table, without much/any relationship between the objects in the table (or between tables).

# Redshift

Redshift is Amazon’s solution for data lakes/warehouses. It’s optimized for dealing with large quantities of _static_ data. Structured (pentabytes) and unstructured (exabytes) data is supported.

# Database Migration Service

Amazon DMS is designed to handle realtime migration from on-prem databases to EC2, RDS, or DynamoDB. It supports both homogenous (between databases of the same type) and heterogenous (between databases of different types) migrations. DMS is designed to migrate data without requiring downtime in either the source or destination DBs.

DMS also supports migration _between_ EC2 and RDS accounts.

DMS can also be used for replication, DB consolidation, and the creation of development/testing data sets from production data.

# Other AWS Database Services

Additional, more specialized, DB options:

- DocumentDB - NoSQL system optimized for content management systems, based on MongoDB.
- Neptune - a graph database (social networks, recommendation engines, fraud detection, etc.).
- Managed Blockchain
- Quantum Ledger Database - basically a WORM database for highly regulated institutions.

DB extensions:

- ElastiCache - memcached and Redis.
- DAX - cacheing for DynamoDB.
