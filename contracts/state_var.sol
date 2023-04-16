// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity 0.8.19;

contract state_var {
    string public test;

    function set(string memory _test) public {
        test = _test;
    }

    function view_test() public view returns (string memory) {
        return test;
    }

    function set2(string calldata _test) public {
        test = _test;
    }

    function processData(uint[] calldata inputData) public pure returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < inputData.length; i++) {
            sum += inputData[i];
        }

        uint average = sum / inputData.length;
        uint[] memory outputData = new uint[](inputData.length);
        for (uint i = 0; i < inputData.length; i++) {
            outputData[i] = inputData[i] - average;
        }

        return outputData[0];
    }
}
