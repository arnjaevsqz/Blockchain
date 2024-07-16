// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {

    mapping(string => uint256) public vapePrices;
    mapping(address => mapping(string => uint256)) public ownedVape;

    event VapePurchased(address indexed buyer, string vapeType);

    constructor() ERC20("Degen", "DGN") {
        // Initialize vape prices
        vapePrices["Aegis"] = 2500;
        vapePrices["Black Elite"] = 7000;
        vapePrices["RelX"] = 12000;
        vapePrices["GeekBar"] = 1200;
    }

    function buyVape(string memory vapeType) public {
        require(vapePrices[vapeType] > 0, "Invalid vape type");
        require(balanceOf(msg.sender) >= vapePrices[vapeType], "Insufficient DGN balance");

        _transfer(msg.sender, address(this), vapePrices[vapeType]);
        ownedVape[msg.sender][vapeType] += 1; // Increment owned vape
        emit VapePurchased(msg.sender, vapeType);
    }

    function getOwnedVape(address owner, string memory vapeType) public view returns (uint256) {
        return ownedVape[owner][vapeType];
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