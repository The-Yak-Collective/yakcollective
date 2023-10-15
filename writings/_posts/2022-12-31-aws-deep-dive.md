---
title: AWS Deep Dive
date: 2022-12-31 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-12-31-aws-deep-dive.html
author: 100007
---

# AWS KMS Cryptographic Details

## Working with AWS KMS Keys

- [Working with AWS KMS keys](https://docs.aws.amazon.com/kms/latest/cryptographic-details/kms-keys.html)

### Calling CreateKey

By default, KMS creates symmetric keys.

Interestingly, ARNs are generated _before_ key material is requested from the HSM. I’d naively expect that an ARN would only be created _after_ successful HBK generation.

- [Calling CreateKey](https://docs.aws.amazon.com/kms/latest/cryptographic-details/create-key.html)

### Importing Key Material

KMS only supports the import of 256-bit symmetric keys. This _cannot_ be uploaded as plain text, but must instead be pre-encrypted using a public key provided by KMS as part of the import sequence.

Unlike HBKs (which are retained after expiration to enable the decryption of older ciphertexts), imported key material is _deleted_ upon expiration.

- [Importing key material](https://docs.aws.amazon.com/kms/latest/cryptographic-details/importing-key-material.html)

### Deleting Keys

KMS keys can be deleted; there’s by default a 7-day “grace period” before deletion during which the key is disabled before deletion… It’s not clear if key deletion can be canceled during this window, however.

- [Deleting keys](https://docs.aws.amazon.com/kms/latest/cryptographic-details/key-deletion.html)

### Rotating Key Material

KMS provides a `ReEncrypt()` API to re-encrypt ciphertext that was encrypted using a previous HBK with the current HBK (via the HSM, ensuring that plaintext is never exposed). However, this API is a manual call - ciphertext is _not_ re-encrypted to new HBKs on key rotation (for obvious reasons, if you think about how diverse the AWS infrastructure is).

- [Rotating key material](https://docs.aws.amazon.com/kms/latest/cryptographic-details/rotate-customer-master-key.html)

## Customer Data Operations

Encrypted data is basically clear text metadata + ciphertext + an integrity mechanism (I assume a signature of the concatenation of both parts?).

- [Customer data operations](https://docs.aws.amazon.com/kms/latest/cryptographic-details/customer-data-operations.html)

### Encrypt

Okay, so the 4 KB limit is only for “direct” calls to KMS - apparently the AWS Encryption SDK allows larger blobs to be encrypted. I’m still curious if this is via some kind of semi-private API, or if instead larger blobs are chunked into 4 KB segments and then stored as some kind of ordered data structure.

- [Encrypt](https://docs.aws.amazon.com/kms/latest/cryptographic-details/encrypt-operation.html)

### Decrypt

Apparently, services identify themselves to KMS when using a grant by providing some kind of token related to this grant. I’m going to guess that these tokens must include some kind of time-based signature in order to protect them against being used if leaked?

The only “authentication” that the returned plaintext is authentic is that it includes a key ID that should match the key that was used to encrypt the original ciphertext. Seems… Like not a very strong way of authenticating the returned plaintext?

- [Decrypt](https://docs.aws.amazon.com/kms/latest/cryptographic-details/decrypt-operation.html)

### Re-Encrypting an Encrypted Object

The `ReEncrypt()` API is actually pretty general - it can be used to re-encrypt a ciphertext using the current HBK of the original KMS key, the current HBK of a _different_ KMS key, or change the encryption context (which is done in conjunction with one of the two previous operations).

Again, the only authentication that the returned ciphertext is authentic is the key ID used in the original ciphertext.

- [Reencrypting an encrypted object](https://docs.aws.amazon.com/kms/latest/cryptographic-details/reencrypting-an-encrypted-object.html)

## AWS KMS Internal Operations

- [AWS KMS internal operations](https://docs.aws.amazon.com/kms/latest/cryptographic-details/kms-internals.html)

### Domains and Domain State

HSMs and associated keys and _internal_ services/operators are grouped into logical domains. HSMs do _not_ communicate with each other, even to synchronize domain keys. Instead, a quorum of operators requests an updated domain state from one HSM and then distributes that updates (and authenticated) domain state to all HSMs in the domain. Importantly, the HSM generating the new domain state does _not_ update its own state when generating a new domain state; rather, it only updates state when it receives back the authenticated updated domain state that it previously generated.

In practice, the operators don’t communicate with the HSMs directly; rather, commands are requested and distributed through a (dedicated?) service host within the KMS domain.

It sounds like HSMs always retain the current and previous domain key upon domain key rotation; the previous retained domain key is discarded during this process. (Again, I assume that HBKs must get re-encrypted immediately after domain key rotation, since only a limited number of previous domain keys are retained within the HSM memory.)

- [Domains and domain state](https://docs.aws.amazon.com/kms/latest/cryptographic-details/domains-and-domain-state.html)

### Internal Communication Security

Commands between a domain’s service host and the associated HSMs are all envelope encrypted using a periodically renegotiated session key.

- [Internal communication security](https://docs.aws.amazon.com/kms/latest/cryptographic-details/internal-communication-security.html)

### Replication Process for Multi-Region Keys

Inter-region replication is similar to internal communication, except that dedicated “replication signing keys” are used. A proxy service is used to transmit data between the two (regional) KMS domains. (Presumably, the proxy talks to each domain’s service host, rather than to the HSMs directly, though this isn’t entirely clear from the documentation.)

- [Replication proces for multi-Region keys](https://docs.aws.amazon.com/kms/latest/cryptographic-details/replicate-key-details.html)

### Durability Protection

All KMS domains contain some number of offline HSMs that are part of the domain, but stored in a powered-down state in multiple locations. Access to the safes storing these HSMs requires at least one AWS security officer and one AWS KMS operator from _different_ teams.

Presumably there must be some rotation between online and offline HSMs to ensure that offline HSM state doesn’t become too “stale”.

- [Durability protection](https://docs.aws.amazon.com/kms/latest/cryptographic-details/durability-protection.html)
