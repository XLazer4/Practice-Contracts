// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract structt {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] public todo;

    function create(string calldata _text) public {
        todo.push(Todo(_text, false));
    }

    function get(uint _index) public view returns (string memory, bool) {
        Todo storage check = todo[_index];
        return (check.text, check.completed);
    }
}
