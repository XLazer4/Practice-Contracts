pragma solidity >=0.8.0 <0.9.0;
//SPDX-License-Identifier: MIT

import "hardhat/console.sol";
// import "@openzeppelin/contracts/access/Ownable.sol"; 
// https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol

contract YourContract {

    uint256 public balance;
    address public owner;
    string public bankname;
    mapping(address => uint256) customerbalance;

    constructor() {
        console.log("\n                        ****Itz da Bank**** \n");
        owner = 0x9AE10b00A876255FA7eD0e359D9e373Bf12a125c;
    }

    function deposit() external payable{
        require(msg.value != 0, "You need to deposit some amount of money!");
        customerbalance[msg.sender] += msg.value;
        console.log("%s",msg.sender," deposited ",msg.value);
    }

    function setBankName(string memory _name) external {
        require(msg.sender == owner, "You must be the owner to set the name of the bank");
        bankname = _name;
    } 

    function viewbalance() external view returns(uint256)
    {
        console.log(msg.sender,"'s Balance = ", customerbalance[msg.sender],"\n");
        return(customerbalance[msg.sender]);
    }
    
    function withdraw(uint256 _amount) external payable{
        if(_amount <= customerbalance[msg.sender])
        {
            (bool success, ) = (msg.sender).call{value: _amount}("");
            customerbalance[msg.sender] -= _amount;
            require(success, "Failed to withdraw money");
            console.log(msg.sender," withdrew ",_amount);
        }
        else
        {
            console.log("Insufficient Balance ");
            console.log("Current Balance: ", customerbalance[msg.sender], "\n");
        }
    }

    function bankbalance() external view returns(uint256)
    {
        require(msg.sender == owner,"You must be the owner of the bank to see all balances.");
        console.log("Bank Balance: ", address(this).balance, "\n");
        return address(this).balance;
    }
}
