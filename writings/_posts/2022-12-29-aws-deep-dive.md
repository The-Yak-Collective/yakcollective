---
title: AWS Deep Dive
date: 2022-12-29 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-12-29-aws-deep-dive.html
author: 100007
---

I’m _finally_ done reading about Amazon’s API Gateway. Now on to reading about the AWS Key Management Service (KMS)!

# AWS KMS Cryptographic Details

## Introduction

The KMS HSMs are all FIPS 140-2 validated

- [Introduction to the Cryptographic Details of AWS KMS](https://docs.aws.amazon.com/kms/latest/cryptographic-details/intro.html)

### Basic Concepts

There are three types of KMS keys:

- _Customer managed keys_ are fully controlled by a given AWS account.
- _AWS managed keys_ are controlled by AWS but still live within an AWS account. My impression is that these keys are generally automatically created when a service is configured to provide encryption services; I’m guessing that things like S3 bucket encryption keys fall into this category.
- _AWS owned keys_ are internal keys used by AWS. They are _not_ associated with customer accounts and do not show up in logs (unlike the other two key types).

Keys can have both permissions (IAM resource policies) and _grants_, which are delegated permissions _not_ managed by IAM. Grants are used to allow services to perform encryption operations asynchronously on behalf of a given principal.

The ciphertext produced by AWS KMS contains not only the encrypted data, but also the identifier for the KMS key to use for decryption. Interestingly, it seems that KMS is limited to encrypting only 4 KB of data at a time. (This makes me wonder how things like S3 encryption work. Is data being chunked before encryption? Or does S3 do its own encryption and decryption using a key that’s protected with KMS?)

KMS ciphertext can optionally depend on “context” information passed in at during initial encryption. This context is _not_ returned with the ciphertext, but the ciphertext _cannot_ be decrypted without it. (This makes me think that the context is used as part of the encryption key in some way.) It’s worth noting that context should _not_ be sensitive information, as it _will_ be logged.

When used with asymmetric encryption, only the private part of the key pair is managed by the HSMs (which makes sense, if you think of how public keys are derived and used).

- [Basic concepts](https://docs.aws.amazon.com/kms/latest/cryptographic-details/basic-concepts.html)

### AWS KMS Design Goals

Internal administrative actions on HSMs (all?) use quorum-based access control mechanisms.

- [AWS KMS design goals](https://docs.aws.amazon.com/kms/latest/cryptographic-details/design-goals.html)

## AWS Key Management Service Foundations

- [AWS Key Management Service foundations](https://docs.aws.amazon.com/kms/latest/cryptographic-details/foundation.html)

### Cryptographic Primitives

Symmetric encryption is currently handled using AES-GCM with 256-bit keys. The initial symmetric encryption key is never directly used (if I understand this section correctly); rather a new key is derived from this master key for each encryption call.

Asymmetric encryption uses RSA or ECC keys and supports a variety of key lengths (for RSA) or curves (for ECC).

It sounds like encryption context information may be included when a hash is generated to verify the integrity of the encrypted information. In which case it’s not so much that failure to include the proper context will result in a decryption failure as it will result in a _verification_ failure (and presumably the HSM just doesn’t return plaintext that fails verification).

All intra-KMS communications are verified using ECDSA signatures.

- [Cryptographic primitives](https://docs.aws.amazon.com/kms/latest/cryptographic-details/crypto-primitives.html)

### AWS KMS Key Hierarchy

AWS KMS basically work a bit like a hierarchical deterministic wallet - there’s some central “domain key” that’s stored on the HSM, and then an (encrypted) “HSM backing key” (HBK) is derived and exported from it. Key “rotation” consists of deriving a new HBK. While KMS ARNs point to the domain key, they functionally reference the current HBK for new encryption operations and whichever HBK was used to encrypt a given ciphertext for decryption operations.

Additional customer data keys (CDKs) can in turn be derived from the currently active HBK. Unlike HBKs, CDKs can be exported as plaintext (though the default still appears to be ciphertext).

Decrypting information requires that both the ciphertext and corresponding HBK (or CDK, presumably if its returned as ciphertext) be passed back to the HSM; this is essentially envelope encryption where the encrypted key material has been separated from the corresponding ciphertext and is kept within the KMS system.

Apparently domain keys are rotated daily-to-weekly. I assume this means that all HBKs need to be re-encrypted on this frequency as well?

- [AWS KMS key hierarchy](https://docs.aws.amazon.com/kms/latest/cryptographic-details/key-hierarchy.html)
- [BIP 32: Hierarchical Deterministic Wallets](https://github.com/bitcoin/bips/blob/master/bip-0032.mediawiki)
- [BIP 39: Mnemonic Code for Generating Deterministic Keys](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki)
- [BIP 44: Multi-Account Hierarchy for Deterministic Wallets](https://github.com/bitcoin/bips/blob/master/bip-0044.mediawiki)

## AWS KMS Use Cases

- [Use cases](https://docs.aws.amazon.com/kms/latest/cryptographic-details/use-cases.html)

### Amazon EBS Volume Encryption

EBS volumes work via a KMS grant that allows for the generation and on-demand decryption of volume keys. (I assume that these are a species of CDK?) Volume keys are stored in encrypted for along with the EBS volume, and then passed back to KMS for decryption at mount time.

EBS seems to work similarly to LUKS and similar systems, in that the decrypted volume key is held in the memory of the EC2 instance using the volume as long as that volume is mounted.

- [Amazon EBS volume encryption](https://docs.aws.amazon.com/kms/latest/cryptographic-details/ebs-volume-encryption.html)

### Client-Side Encryption

The AWS Encryption SDK provides hooks for envelope encryption, where the “long term” key for decrypting the message key is held in KMS.

- [Client-side encryption](https://docs.aws.amazon.com/kms/latest/cryptographic-details/client-side-encryption.html)
