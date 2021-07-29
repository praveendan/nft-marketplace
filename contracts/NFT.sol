// contracts/NFT.sol
// SPDX-License-Identifier: MIT OR Apache-2.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

import "hardhat/console.sol";

contract NFT is ERC721URIStorage {
  using Counters for Counters.Counter;
  //incrementing tokenIds using counters package
  Counters.Counter private _tokenIds;
  //marketplace address
  address contractAddress;

  constructor(address marketplaceAddress) ERC721("Metaverse Tokens", "METT") {
    contractAddress = marketplaceAddress;
  }

  function createToken(string memory tokenURI) public returns (uint) {
    _tokenIds.increment();
    uint256 newItemId = _tokenIds.current();

    //creator, tokenId-like a primary key
    _mint(msg.sender, newItemId);
    _setTokenURI(newItemId, tokenURI);
    //give marketplace approval to transactions
    setApprovalForAll(contractAddress, true);
    return newItemId;
  }

}
