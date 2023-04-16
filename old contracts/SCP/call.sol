// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract A {
    uint public test = 4;

    function getTest() public view returns (uint) {
        return test;
    }
}

contract B {
    address public contractA;

    event Response(bool success, uint data);

    constructor(address _contractA) {
        contractA = _contractA;
    }

    function getgetTest() public {
        (bool success, bytes memory data) = contractA.call(
            abi.encodeWithSignature("getTest()")
        );

        if (success) {
            uint result = abi.decode(data, (uint));
            emit Response(true, result);
        } else {
            emit Response(false, 0);
        }
    }
}
