// SPDX-License-Identifier: GLP-3.0

pragma solidity ^0.8.4;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";

contract duckcoin is ERC20, ERC20Burnable, Ownable {
    event tokensburned(address indexed owner, uint256 amount, string message);
    event tokensMinted(address indexed owner, uint256 amount, string message);
    event additionaltoken(address indexed owner, uint256 amount,string message);

    constructor() ERC20("DuckCoin", "DCC"){
        //decimals is 18 here
        _mint(msg.sender, 10000*10**decimals());
        emit tokensMinted(msg.sender, 10000*10**decimals(), "Initial supply");
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
        emit additionaltoken(msg.sender, amount, "Addition DuckCoins minted :)");
    }
    //overriding ERC20 to use burn function of ERC20Burnable
    function burn(uint256 amount) public override onlyOwner{
        _burn(msg.sender, amount);
        emit tokensburned(msg.sender, amount, "DuckCoins Burned :(");
    }
}
