# ERC20 Token 

This project implements a fungible token contract named DegenToken on the Ethereum blockchain. It adheres to the ERC20 standard, allowing seamless integration with existing Ethereum wallets and exchanges. However, this token serves a unique purpose: facilitating vape purchases!

## Description

DegenToken offers a novel way for gaming enthusiasts specifically on Honor of KIngs. Users can hold and transfer DGN tokens, the native currency of this ecosystem. These tokens are used to purchase virtual heroes represented by various hero types stored in the contract.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.
Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```
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
```  

## Authors

Aaron Vasquez
aaronjvsqz@gmail.com


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
