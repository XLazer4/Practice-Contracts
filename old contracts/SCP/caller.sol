// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "./callee.sol";

contract Caller {
    function setXFromAddress(address _addr, uint _x) public {
        Callee callee = Callee(_addr);
        callee.setX(_x);
    }
}
