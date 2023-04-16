// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract order {
    enum Status {
        On,
        Off
    }

    Status public status;

    function changeOn() public {
        require(status == Status.On);
        status = Status.Off;
    }
}
