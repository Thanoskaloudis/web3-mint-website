// contracts/GLDToken.sol
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract PixelPopNFT is ERC721, Ownable {
    uint256 public totalSupply;
    uint256 public maxSupply;
    uint256 public mintPrice = 0.02 ether;
    bool public isMintEnabled;
    string internal baseTokenUri;
    
    mapping(address => uint256) public mintedWallets;

    constructor() payable ERC721("PixelPopNFT", "PPNFT") {
        totalSupply = 0;
        maxSupply = 20;
    }

    function toggleIsMintEnabled(bool isMintEnabled_) external onlyOwner {
        isMintEnabled = isMintEnabled_;
    }

    function setBaseTokenUri (string calldata baseTokenUri_) external onlyOwner {
        baseTokenUri = baseTokenUri_;
    }

    function tokenURI (uint256 tokenId_) public view override returns (string memory) {
        require(_exists(tokenId_), 'Token does not exist!');
        return string(abi.encodePacked(baseTokenUri, Strings.toString(tokenId_), ".json"));
    }


    function mint() external payable {
        require(isMintEnabled, 'Minting is enabled');
        require(mintedWallets[msg.sender] < 1, 'exceeds max per wallet');
        require(msg.value == mintPrice, 'wrong value');
        require(maxSupply > totalSupply, 'sold out');

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }
}
