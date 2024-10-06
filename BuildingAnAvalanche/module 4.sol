// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    mapping(string => uint256) public heroPrices;
    mapping(address => mapping(string => uint256)) public ownedHero;

    event HeroPurchased(address indexed buyer, string heroType);

    constructor() ERC20("Degen", "DGN") {
        // Initialize hero prices
        heroPrices["Shouyue"] = 2500;
        heroPrices["Guiguzi"] = 7000;
        heroPrices["Liu Bang"] = 12000;
        heroPrices["Shangguan"] = 1200;
    }

    function buyHer0(string memory heroType) public {
        require(heroPrices[heroType] > 0, "Invalid hero type");
        require(balanceOf(msg.sender) >= heroPrices[heroType], "Insufficient DGN balance");

        _transfer(msg.sender, address(this), heroPrices[heroType]);
        ownedHero[msg.sender][heroType] += 1; // Increment owned hero
        emit HeroPurchased(msg.sender, heroType);
    }

    function getOwnedHero(address owner, string memory heroType) public view returns (uint256) {
        return ownedHero[owner][heroType];
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    function transfer(address to, uint256 amount) public override returns (bool) {
        _transfer(msg.sender, to, amount);
        return true;
    }
}
