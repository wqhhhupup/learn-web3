// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract ValueType {
    bool public isActive = true;


    function toggleActive() public {
        isActive = !isActive;
    }

    int8 signedInt = 32;
    uint8 uInt = 32;

    function divide(uint x, uint y ) public pure  returns (uint8) {
        return x / y
    }

    function add() public pure returns (uint8) {
        uInt8 a = 16
        uint8 b = 239 

        return a + b // 最大256 2^8-1

    }

    function leftShift(int8 x, int8 y) public pure returns (int) {
        return x << y  // x*2^y
    }

    function rightShift(int8 x, int8 y) public pure returns (int) {
        return x >> y  // x / 2 ^ y
    }



}
