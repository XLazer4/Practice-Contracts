//SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

contract Counter {
    uint public count;

    function inc() external {
        count += 1;
    }

    function dec() external {
        count -= 1;
    }
}

contract Echidna is Counter {
    bool private pass = true;
    uint private immutable createdAt = block.timestamp;

    function echidna_test_timestamp() public view returns (bool) {
        return pass;
    }

    function setFail() external {
        uint delay = 7 days;
        require(block.timestamp >= createdAt + delay);
        pass = false;
    }

    // function echidna_test_count() public view returns (bool) {
    //     return count <= 5;
    // }

}