// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract Array {
    // 静态
    uint[1] public arr;
    string[4] public arr2 = ["a", "b", "c", "d"];

    // 动态
    uint[] public arr3;

    uint[3] arr4;

    constructor() {
        arr4 = [uint(0), uint(0), uint(0)];
    }

    function updateData() public {
        arr3.push(
            uint(
                keccak256(abi.encodePacked(block.timestamp, block.difficulty))
            ) % 100
        );
    }

    function sliceArr(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        uint[] memory res = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            res[i - start] = arr3[i];
        }
        return res;
    }
}

// 实践练习：
// 编写合约，允许用户动态管理一个地址数组。
// 实现一个函数，接收数组作为参数并返回其元素之和。
// 创建一个函数，删除数组中的特定元素并调整数组长度。

contract ArrayTest {
    address[] public arr;

    function addAddress(address _addr) public {
        arr.push(_addr);
    }

    function sumAddress() public view returns (uint) {
        uint sum = 0;
        for (uint i = 0; i < arr.length; i++) {
            sum += uint(uint160(arr[i]));
        }
        return sum;
    }

    function removeAddress(uint index) public {
        require(index < arr.length, "Index out of bounds");
        for (uint i = index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
}

