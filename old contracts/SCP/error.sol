// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Error {
    error InsufficientBalance(uint balance, uint withdrawAmount);
    uint bal = address(this).balance;

    function testCustomError(uint _withdrawAmount) public view {
        // require(bal > _withdrawAmount,"bruh no mone");
        if (bal < _withdrawAmount) {
            revert InsufficientBalance({
                balance: bal,
                withdrawAmount: _withdrawAmount
            });
        }
    }
}
