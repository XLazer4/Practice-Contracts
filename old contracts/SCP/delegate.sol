// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract A {
    uint public num;

    function setVars(uint _num) public {
        num = _num;
    }
}

contract B {
    uint public num;
    event Response(bool success, bytes data);

    function setVars(address _contract, uint _num) public {
        (bool success, bytes memory data) = _contract.delegatecall(
            abi.encodeWithSignature("setVars(uint256)", _num)
        );
        emit Response(success, data);
    }
}
