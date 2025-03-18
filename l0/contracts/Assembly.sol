// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

// 内联汇编

contract Assembly {
    function add(uint x, uint y) public pure returns (uint) {
        assembly {
            let result := add(x, y)
            mstore(0x0, result)
            return(0x0, 32)
        }
    }
}
