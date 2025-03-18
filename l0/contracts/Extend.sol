// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract Car {
    uint public speed;

    function drive(uint _speed) public virtual {
        speed = _speed;
    }
}

contract ElectricCar is Car {
    function drive(uint _speed) public override {
        require(_speed < 100, "Speed must be less than 100");
        speed = _speed;
    }
}

contract Person {
    string public name;
    uint public age;

    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }
}

contract Employee {
    string public position;

    constructor(string memory _position) {
        position = _position;
    }

    function changePosition(string memory _position) public virtual {
        position = _position;
    }
}

contract Manager is Person("erbeisu", 18), Employee("manager") {

    function changePosition(string memory _position) public override {
        require(keccak256(abi.encodePacked(_position)) != keccak256(abi.encodePacked("boss")), "Cannot change to boss");
        position = _position;
    }
}
