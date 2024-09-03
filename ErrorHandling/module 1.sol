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
