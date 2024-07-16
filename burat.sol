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