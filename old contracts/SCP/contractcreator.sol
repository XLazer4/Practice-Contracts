// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Car {
    address public owner;
    string public model;
    address public carAddr;

    constructor(string memory _model) {
        owner = msg.sender;
        model = _model;
        carAddr = address(this);
    }
}

contract CarFactory {
    Car[] public cars;

    function create(string memory _model) public {
        Car car = new Car(_model);
        cars.push(car);
    }

    function create2(
        string memory _model,
        bytes32 _salt
    ) public {
        Car car = (new Car){salt: _salt}(_model);
        cars.push(car);
    }

    function getCar(
        uint _index
    )
        public
        view
        returns (
            address owner,
            string memory model,
            address carAddr
        )
    {
        Car car = cars[_index];

        return (car.owner(), car.model(), car.carAddr());
    }
}
