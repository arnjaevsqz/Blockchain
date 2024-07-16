# Types of Functions

This project implements a fungible token contract named MyToken on the Ethereum blockchain. The code adheres to the ERC20 standard, ensuring seamless integration with existing Ethereum wallets and exchanges that support ERC20 tokens.

## Description

This token contract offers functionalities for managing a custom ERC20 token on the Ethereum blockchain. Users can transfer and hold these tokens, similar to other ERC20 tokens. Additionally, the contract allows burning tokens (removing them from circulation) with access controls and enables the owner to mint new tokens.

## Getting Started

### Executing program

* To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.
* Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```javascript
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts@4.9.0/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.9.0/token/ERC20/extensions/ERC20Burnable.sol";
import "@openzeppelin/contracts@4.9.0/access/Ownable.sol";

contract MyToken is ERC20, ERC20Burnable, Ownable {
    constructor(string memory name, string memory symbol, uint256 initialSupply) ERC20(name, symbol) {
        _mint(msg.sender, initialSupply);
    }

    modifier onlyOwnerOrSelf(address account) {
        require(account == owner() || account == _msgSender(), "Not authorized");
        _;
    }

    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }

    function burnFrom(address account, uint256 amount) public override onlyOwnerOrSelf(account) {
        _burn(account, amount);
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
}

```
To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.0" (or another compatible version), and then click on the "Compile burat.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Sand then click on the "Deploy" button.

Once the contract is deployed, you can interact with it using the functions. click on the "transact" buttons to create transactions

## Authors
Aaron Vasquez
aaronjvsqz@gmail.com

License
This project is licensed under the MIT License - see the LICENSE.md file for details
