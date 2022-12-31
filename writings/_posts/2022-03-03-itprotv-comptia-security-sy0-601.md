---
title: 'ITPro.TV: CompTIA Security+ (SY0-601)'
date: 2022-03-03 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-03-03-itprotv-comptia-security-plus.html
author: 100007
---

# CompTIA Security+ Exam Cram

## Cryptosystems

Cryptosystems are concerned with data confidentiality (encrypting) and integrity (hashing/signing).

Vocabulary:

- Confusion: Each bit of the cyphertext should depend on multiple bits of the plaintext.
- Diffusion: A one bit change in the plaintext should result in a change in _at least_ 50% of the cyphertext.
- Initialization Vector (IV): A fixed-size random or pseudo-random value used to ensure that identical plaintext messages have different cyphertext representations. A salt is a type of IV.
- Nonce: A random or pseudo-random number that is used once and is associated with a timestamp. Used to guard against replay attacks. Can be used as IVs.
- Key Derivation Function (KDF): An algorithm that takes a password and derives a cryptographic key from it.
- Key Stretching: An algorithm that is used to expand a short key to a longer key value.
- Static Key: A key used multiple times (typically for days, months, or years).
- Ephemeral Key: A key used for only a single session.
- Stream Cypher: Combining the plaintext message with a stream of random or pseudo-random characters, one bit at a time. Stream cyphers are low diffusion algorithms.
- Block Cypher: The encryption of a fixed-length “blocks” of bits from the plaintext. Typically uses padding to ensure consistent block sizes for all plaintext messages. Block cyphers are generally high diffusion algorithms.
- Public Key: The _encrypting_/_verifying_ half of an asymmetric keypair.
- Private Key: The _decrypting_/_signing_ half of an asymmetric keypair.
- Nonrepudiation: The use of a cryptosystem to prevent deniability, typically via cryptographic signatures. Note that in a fully nonrepudiable client/server model the host will receive proof of origin (the message comes from the client), while the client will receive proof of submission (the data was sent), delivery (that data was received), and receipt (that data was read correctly).

Block cyphers are generally high diffusion algorithms, while stream ciphers are (necessarily) low diffusion.

Note that really, both the public and private keys in asymmetric encryption schemes and encrypt and decrypt messages - it’s just that you don’t use the public key to decrypt the actual message because _everyone_ potentially has access to it. But the symmetry (heh) in asymmetric keys becomes apparent when you think about what a _signature_ actually is - an encrypted hash of the plaintext.

Finally, the public key in asymmetric cryptography is generally derived from the private key (but the reverse is not possible). This means that it’s often (always?) possible to use the private half of an asymmetric keypair as a symmetric key (not that you’d actually _want_ to do this…).

In a fully asymmetric cryptosystem, each user has a public/private keypair, and uses the recipients public key to encrypt messages to them. This is expensive though, so in general asymmetric cryptography is used in one of two ways:

- To exchange a short-lived symmetric (“session”) key for use in the actual communication, or
- More recently, simply to verify identities and begin a Diffie-Hellman key exchange (after the initial key creation, new Diffie-Hellman exchanges are subsequently conducted as part of every message, allowing session keys to be ratcheted for every message - a method called “forward secrecy”).

Note that while forward secrecy protects against both the (future) disclosure of the private key and harvesting of all on-the-wire messages, it still fails if the attacker has continuous access to the memory of one party and/or the ability to influence the generation of per-message ephemeral secrets.

Other terms for symmetric keys: Secret keys, private keys, shared secrets.

Asymmetric key algorithms are also called public key algorithms.

- [Difference between Asymmetric Encryption and Signing (Digital Signature)](https://coderjony.com/blogs/difference-between-asymmetric-encryption-and-signing-digital-signature/)
- [Forward secrecy (Wikipedia)](https://en.wikipedia.org/wiki/Forward_secrecy)
- [Diffie-Hellman key exchange (Wikipedia)](https://en.wikipedia.org/wiki/Diffie%E2%80%93Hellman_key_exchange)

## Use of Proven Technologies and Implementations

Exam Cram emphasizes several times the efficiency of elliptic curve cryptography (ECC) and its application for mobile devices with more constrained computational or energetic profiles. Which I suspect means that a question like this is likely to be on the Security+ exam.

## Steganography

Exam Cram indicates that the Security+ test is likely to have some kind of question about the difference between steganography and cryptography.

## Cryptography Use Cases

To reiterate, a list of the roles of cryptography in security:

- Confidentiality (encryption)
- Integrity (hashing)
- Nonrepudiation (signing)
- Authentication (can be accomplished via a public/private key cryptography during the initial handshake)

# ITPro.TV: CompTIA Security+ (SY0-601)

# Cryptography

## Cryptography Concepts

> [Cryptography] is trying to make us live in a world that’s “need to know”.
> 
> - Dan Lowrie

The three states of data:

- At rest
- In motion
- In processing

Important cyphers for low-power devices (SCADA, etc.)

- PRESENT
- TWINE

## Encryption And Steganography

Encryption is about ensuring confidentiality; steganography is about hiding information (which may - and probably should be! - itself cyphertext).

Interesting… ITPro.TV is defining a streaming cipher as operating byte-by-byte, whereas Exam Cram defined them as operating bit-by-bit. So either one of these is wrong, or the difference between stream and block cyphers are more a matter of degree than kind (I kind of suspect it’s the latter).

Stream cipher bullet points:

- Bit/Byte-based
- Generally less secure
- Faster

Block cipher bullet points:

- Block-based (64 bits or higher)
- Generally more secure
- Slower

Block cipher modes:

- Electronic Code Book (ECB) - Old, weak
- Cypher Block Encoding (ECC) - Errors in one block will effect the rest of the chain
- Cypher Feedback (CFB) - Allows a block cipher to function more like a stream cipher
- Output Feedback (OFB) - Allows a block cipher to function more like a stream cipher
- Counter Mode (CTR) - Strongest, used by AES

## Hashing

Hashes are always fixed length (for a given hash type). Also, “message digest” == “fingerprint” == “hash”!

- MD5 - 128-bit, prone to collisions (old, weak)
- SHA1 - 160-bit, some collisions
- SHA2 - 224, 256, 384, 512 bit variants (modern)
- RIPEMD - 128, 160, 256, 320 bit variants (uncommon)

HMACs are “hashed message authentication codes” used to verify message integrity and authenticity. HMACs are not hash functions themselves, but are rather encrypted hashes that are appended to messages (so, a signature).

Checksums are not hashing algorithms, but serve a similar purpose.

A note about salts: You _don’t_ want your salt(s) to become public, but it also doesn’t completely negate their value if they are leaked. The reason for this is that, so long as you are using _unique_ salts in every instance, you are still preventing the use of _mass_ password/data cracking. So even a leaked salt buys you time… But that’s the only thing it buys you at that point, so it’s still important to re-encrypt / re-hash / invalidate passwords, etc. if this happens!

## Symmetric vs. Asymmetric Encryption

Symmetric cyphers:

- AES - Block cypher, 128 - 256 bits
- DES - Block cypher, 56-bits
- 3DES - Three DES rounds, 168-bits (effective)
- Blowfish - Block cipher, 64-bit
- RC4 - Stream cypher, used in WEP and WPA
- RC5 - Block cipher variant of RC4
- RC6 - Block cipher variant of RC4

Of these, only AES is considered strong these days.

Asymmetric cyphers:

- RSA - Second oldest, common
- Diffie-Hellman - Oldest standard, used for key exchange
- DSA - NIST “digital security standard”
- EIGamal - Used by PGP/GPG
- ECC - New, fast, small keys

Two applications/machines that try to communicate cryptographically need to first agree on a “cipher suite” - a set of cryptographic algorithms - to use. These are represented in a standard(ish) fashion as “standard name + key exchange + asymmetric cipher (with) symmetric cipher + symmetric cipher mode + HMAC”. For example:

```
TLS_DHE_RSA_WITH_AES_256_GCM_SHA384
```

Has the following parts:

- TLS - standard
- DHE - key exchange method
- RSA - asymmetric cipher
- AES-256 - symmetric cipher
- GCM - symmetric cipher mode
- SHA384 - HMAC
