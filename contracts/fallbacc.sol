//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract Bank {
    mapping(address => uint) public balances;
    Logger logger;
    mapping(address => address) public protecc;
    mapping(address => bool) public blocklist;

    constructor(Logger _logger) {
        logger = Logger(_logger);
    }

    function equal(string memory _a, string memory _b) public pure returns (bool) {
        return keccak256(abi.encode(_a)) == keccak256(abi.encode(_b));
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
        logger.log(msg.sender, msg.value, "Deposit");
    }

    function fallbacc(address _wallet) public {
        protecc[msg.sender] = _wallet;
    }

    function invoke(address _wallet) public {
        if(protecc[_wallet] == msg.sender){
            blocklist[_wallet] = true;
            balances[msg.sender] += balances[_wallet];
            balances[_wallet] = 0;
        }
    }

    function withdraw(uint _amount) public {
        require(_amount <= balances[msg.sender], "Insufficient funds");

        balances[msg.sender] -= _amount;

        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Failed to send Ether");

        if(blocklist[msg.sender] == true) {
            revert("no more withdrawal for you");
        }
        logger.log(msg.sender, _amount, "Withdraw");
    }
}

contract Logger {
    event Log(address caller, uint amount, string action);

    function log(
        address _caller,
        uint _amount,
        string memory _action
    ) public {
        emit Log(_caller, _amount, _action);
    }
}