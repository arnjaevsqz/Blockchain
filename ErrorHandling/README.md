# Error Handling

This Solidity code defines a smart contract named errorHandling that manages a simple account system with basic deposit, transfer, and withdrawal functionalities. It also demonstrates the use of revert for intentional error handling.

## Description

This Solidity smart contract provides a foundational framework for account management and error handling. It includes functions for depositing, transferring, and withdrawing Ether, along with robust error checking to ensure data integrity.

## Getting Started

### Executing program

To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.
Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., HelloWorld.sol). Copy and paste the following code into the file:

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract errorHandling {
    mapping(address => uint) public balances;

    event Deposit(address indexed from, uint value);
    event Transfer(address indexed to, uint value);
    event Withdraw(address indexed to, uint value);
    event SentEther(address indexed from, address indexed to, uint value);

    function deposit(uint amount) public payable {
        require(amount > 0, "Must deposit a non-zero amount");
        balances[msg.sender] += amount;
        emit Deposit(msg.sender, amount);
    }

    function transfer(address to, uint value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");
        require(to != address(0), "Invalid address");

        balances[msg.sender] -= value;
        balances[to] += value;
        emit Transfer(to, value);
    }

    function withdraw(uint value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");
        balances[msg.sender] -= value;

        emit Withdraw(msg.sender, value);
    }

    function sendEtherWithRevert(address to, uint value) public {
        require(balances[msg.sender] >= value, "Insufficient balance");
        require(to != address(0), "Invalid address");

        balances[msg.sender] -= value;
        balances[to] += value;
        emit SentEther(msg.sender, to, value);

        revert("Intentional revert");
    }
}
```  

## Authors

Aaron Vasquez
aaronjvsqz@gmail.com


## License

This project is licensed under the MIT License - see the LICENSE.md file for details
