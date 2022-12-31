---
title: Trying (and Failing) to Deploy a Smart Contract Using an iPad Pro
date: 2022-11-27 12:00:00.000000000 Z
layout: post-external
original_link: https://cardboard-iguana.com/log/2022-11-27-trying-and-failing-to-deploy-a-smart-contract-using-an-ipad-pro.html
author: 100007
---

My personal project this weekend was to deploy a smart contract to the Ethereum blockchain. The motivation here was to be able to mint an NFT (really, several NFTs) for use as an avatar on Farcaster, an alternative to Twitter that I’ve been experimenting with for a few weeks now. Using an NFT as your avatar on Farcaster adds a “purple checkmark” to your account, a spoof on Twitter’s infamous blue checkmark.

- [Farcaster](https://www.farcaster.xyz/)
- [necopinus - fcast.me](https://fcast.me/necopinus)
- [How to get a purple checkmark](https://farcasterxyz.notion.site/How-to-get-a-purple-checkmark-fb66f0cb0f5f4f24b699b8f288a2f14a)
- [How to get verified on Twitter](https://help.twitter.com/managing-your-account/about-twitter-verified-accounts)

(For those who are interested, Twitter provides the ability to set an NFT as your avatar, though you need to subscribe to “Twitter Blue” and be using iOS in order to access this feature.)

- [How do I set my NFT as my Twitter profile picture?](https://support.opensea.io/hc/en-us/articles/4415562648851-How-do-I-set-my-NFT-as-my-Twitter-profile-picture-)

The central problem here is that if I use an NFT as my avatar, then I need to pay for another NFT (either to buy one or mint one myself) whenever I decide I want to change my avatar. Also, my current (and favorite) avatar is taken from a John Schoenherr painting of one of the great sandworms of Arrakis - I’m not sure I want to “mint” that in any way that could be interpreted as me claiming “ownership” of it. It’s Schoenherr’s painting after all!

- [The Artists Who Visited “Dune” and “The Most Important Science Fiction Art Ever Created”](https://dangerousminds.net/comments/the_artist_who_visited_dune)

Finally, all of the services I’ve seen that allow you to mint your own NFT store the associated JSON metadata and image file using a decentralized solution like IPFS or Arweave. This is actually a good thing, because it gives “collectable” NFTs a degree of permanence, but in my case I actually _want_ to be able to update the associated metadata and image arbitrarily. Fortunately, I control my own domain and EIP-721 (which defines the NFT standard) doesn’t forbid using “non-permenant” URIs, so all this means is that I need to deploy my own smart contract to create my NFT avatar(s), rather than using a pre-packaged solution.

- [IPFS](https://ipfs.tech/)
- [Arweave](https://www.arweave.org/)
- [EIP-721: Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721)

That all sounds easy enough, but I _also_ wanted to try to do this using only my iPad Pro, since I regard that as a more secure computing device than a regular desktop. (In fact, I’ve gradually come to prefer my iPad Pro over my laptop, so it’s not _just_ about system security.) As you can probably guess from the title of this post, I failed to accomplish this particular goal… Though I came _very_ close to succeeding!

While working on the iPad, I used Safari with the Light Wallet extension for interacting with the Ethereum blockchain.

- [Light Wallet](https://wallet.light.so)

As fate would have it, I started using a standard location for my avatar (`https://necopinus.xyz/​avatar/​avatar.webp`) when I set up my ENS domains. For some reason the correct URL isn’t showing up on the ENS console, even though it appears to be set when I view it in the controling Safe app. I’m not sure why this is, but the important thing is that I already have a standard location for my avatar.

- [necopinus.xyz on ENS](https://app.ens.domains/name/necopinus.xyz/details)
- [Safe](https://app.safe.global/)

The first real step was thus to upload a JSON metadata file pointing to this avatar.

```
{
	"description":"The avatar NFT for necopinus.",
	"external_url":"https://necopinus.xyz/",
	"image":"https://necopinus.xyz/avatar/avatar.webp",
	"name":"necopinus"
}
```

I put this at `https://necopinus.xyz/​avatar/​ethereum/​<WALLET_ADDRESS>.json` to make it straight forward to support additional wallets and blockchains in the future.

Once this was done, I decided to more-or-less follow the “How to Develop an NFT Smart Contract (ERC721) with Alchemy” walk-through. I’m going to skip a lot of the details here, so if you’re trying to do this yourself you should also read through that document.

- [How to Develop an NFT Smart Contract (ERC721) with Alchemy](https://docs.alchemy.com/docs/how-to-develop-an-nft-smart-contract-erc721-with-alchemy)

I also tested deploying the smart contract and minting my NFTs on the Goerli TestNet before committing any money to deploy on the Ethereum MainNet. To do this, you’ll need to get some GoerliETH; the easiest way to do this is to create an account on Alchemy and then visit the Goerli “faucet”, which will transfer 0.2 GoerliETH to your wallet (more than enough for what follows.

- [Alchemy](https://www.alchemy.com)
- [Goerli FAUCET](https://goerlifaucet.com/)

Next, go to the Open Zeppelin Contracts Wizard to pre-generate smart contract code. I’m going to select an ERC721 contract and select the “Mintable, Autoincrement IDs”, “Enumerable”, and “URI Storage” options + uncreative contract and token names. This produces the following code.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract NFTAvatar is ERC721, ERC721Enumerable, ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;

    constructor() ERC721("NFTAvatar", "NFTAVATAR") {}

    function safeMint(address to, string memory uri) public onlyOwner {
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, uri);
    }

    // The following functions are overrides required by Solidity.

    function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
```

- [Open Zeppelin Contracts Wizard](https://docs.openzeppelin.com/contracts/4.x/wizard)
- [nft-avatar.sol](https://cardboard-iguana.com/log/assets/nft-avatar.sol)

Since I’m _not_ producing NFTs for public consumption, I skipped the parts of the Alchemy walk-through where this code was modified to cap the number of NFTs and make it possible for addresses other than the contract’s owner to call it.

Up until now, Safari, Light Wallet, and the iPad Pro work swimmingly. Unfortunately, the web-based Ethereum Remix IDE, which is how we’ll deploy the smart contract code above, does _not_ play well with this setup. The issue might be Safari, or it might be Light Wallet; I’m not sure, but the behavior of Remix on both iPadOS and macOS is identical: You can compile the smart contract code (though lockdown mode must be disabled for the site), but attempting to deploy the code always results in a mysterious “Transaction Failed” error message.

Eventually I installed Brave on my MacBook for the sole purpose of being able to deploy the smart contract code. Brave’s built-in wallet works perfectly with Remix.

- [Brave Browser](https://brave.com/)
- [Brave Wallet](https://brave.com/wallet/)

You’ll want to note down the version of Solidity you used to compile the smart contract, the wallet address you used to deploy it, and the smart contract’s address on the blockchain. With this information, you can always return to remix, recompile the smart contract code, connect the controlling wallet, and then reconnect to the smart contract to mint additional NFTs.

Once the contract was deployed, the only other stumbling block I ran into was that it’s not obvious that the `safeMint` function requires _two_ arguments - the first is the address to send the NFT to, and the second is the metadata URI. You can use the chevron next to the function name in Remix to expand both arguments into separate fields, which makes it more obvious how to enter in the necessary information.

The `tokenURI` function is also useful: When called with the token ID (an incrementing integer, starting at 0), it will return the metadata URI for the corresponding NFT.

The minted NFTs took a looooong time to show up in MetaMask, but they did show up in OpenSea pretty much immediately. You can use the OpenSea interface to transfer the minted NFTs to other accounts.

- [MetaMask](https://metamask.io)
- [OpenSea](https://opensea.io)
- [OpenSea Testnets](https://testnets.opensea.io)

It’s worth noting here that viewing and transferring any NFTs you mint works fine on Safari + Light Wallet. It’s _only_ the Remix IDE that doesn’t like that setup, and in fact it’s _only_ deploying and interacting with your contract that’s broken. Everything else in this process can be done using iPadOS. Hopefully this situation will improve over time.

