// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract PixelPop is ERC721 {
    using SafeMath for uint256;

    address public owner;
    mapping(address => uint256) public balances;
    uint256 public totalSupply;

    constructor(uint256 initialSupply) ERC721("PixelPop", "PXP") {
        owner = msg.sender;
        _mint(msg.sender, initialSupply);
        _burn(initialSupply);
    }

    function mint(address payable to, uint256 amount) public {
        require(msg.sender == owner, "Only the owner can mint new tokens");
        require(amount > 0, "Cannot mint zero or negative token amount");
        require(totalSupply.add(amount) <= 0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff, "Total supply should not exceed the maximum limit of 2^256 - 1");
        _mint(to, amount);
        totalSupply = totalSupply.add(amount);
        balances[to] = balances[to].add(amount);
    }

    function burn(address payable from, uint256 amount) public {
        require(msg.sender == owner, "Only the owner can burn tokens");
        require(amount > 0, "Cannot burn zero or negative token amount");
        require(balances[from] >= amount, "The account does not have enough tokens to burn");
        _burn (amount);
        totalSupply = totalSupply.sub(amount);
        balances[from] = balances[from].sub(amount);
    }

    function transfer(address payable to, uint256 amount) public {
        require(amount > 0, "Cannot transfer zero or negative token amount");
        require(balances[msg.sender] >= amount, "The account does not have enough tokens to transfer");
        require(to != address(0), "Cannot transfer to address 0x0");
        _transfer(msg.sender, to, amount);
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[to] = balances[to].add(amount);
    }
}