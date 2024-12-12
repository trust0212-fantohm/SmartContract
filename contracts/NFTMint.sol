// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

// Uncomment this line to use console.log

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NFTMint is ERC721, Ownable {
    uint256 public totalSupply = 100;
    uint256 public mintedCount = 0;
    address public minter;

    mapping(address => bool) public alreadyMinted;

    event NFTMinted(address indexed minter, uint256 tokenId);

    constructor(
        address _minter
    ) ERC721("SepoliaNFT", "SPLNFT") Ownable(msg.sender) {
        minter = _minter;
    }

    modifier canMint(address user) {
        require(mintedCount < totalSupply, "Max supply reached");
        require(!alreadyMinted[user], "User has already minted an NFT");
        _;
    }

    modifier onlyMinter() {
        require(msg.sender == minter, "Only minter can mint NFT");
        _;
    }

    function mintNFT(address user) external onlyMinter canMint(user) {
        uint256 tokenId = mintedCount;
        mintedCount++;
        alreadyMinted[user] = true;
        _safeMint(user, tokenId);

        emit NFTMinted(user, tokenId);
    }

    function setMinter(address newMinter) external onlyOwner {
        require(newMinter != address(0), "Invalid minter");

        minter = newMinter;
    }
}
