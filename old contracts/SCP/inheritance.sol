// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract inheritA {
    function yo() public pure returns (uint) {
        return 1;
    }
}

contract inheritB is inheritA {}

contract A {
    uint public test = 4;

    function getTest() public view returns (uint) {
        return test;
    }
}

// contract B is A {
//     uint override public test = 5;
// }

contract C is A {
    constructor() {
        test = 6;
    }
}
