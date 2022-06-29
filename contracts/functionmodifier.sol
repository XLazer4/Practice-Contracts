// SPDX-License-Identifier: MIT
pragma solidity ^0.8.3;

contract FunctionModifier {

    address public owner;
    uint public x = 10;
    bool public locked;

    constructor(){
        owner = msg.sender;
    }

    modifier OnlyOwner(){
        require(msg.sender == owner, "Hush Away");
        _;
    }

    modifier validAddress(address _addr){
        require(_addr != address(0),"Invalid address");
        _;
    }

    function changeOwner(address _owner) public OnlyOwner validAddress(_owner){
        owner = _owner;
    }

    // This modifier prevents a function from being called while
    // it is still executing.
    modifier noReentrancy() {
        require(!locked, "No reentrancy");

        locked = true;
        _;
        locked = false;
    }

    function decrement(uint i) public noReentrancy {
        x -= i;
        if (i > 1) {
            decrement(i - 1);
        }
    }

}