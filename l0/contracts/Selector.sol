// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract Hello {
    function double(uint x, uint y) public pure returns (uint) {
        return x * y;
    }
}

contract Selector {
    Hello hello;

    constructor(address _hello) {
        hello = Hello(_hello);
    }

    function getSelector() public pure returns (bytes4) {
        return this.getSelector.selector;
    }

    function getSelector2() public pure returns (bytes4) {
        bytes4 selector = bytes4(keccak256("getSelector2(bytes4)"));
        return selector;
    }

    function add(uint x, uint y) public pure returns (uint) {
        return x + y;
    }

    function select(uint x, uint y) public returns (uint) {
        (bool success, bytes memory data) = address(hello).call(
            abi.encodeWithSelector(hello.double.selector, x, y)
        );
        require(success, "Failed to call");
        return abi.decode(data, (uint));
    }

    function select2(uint x, uint y) public view returns (uint) {
        return hello.double(x, y);
    }

    function select3(uint x, uint y) public returns (uint) {
        (bool success, bytes memory data) = address(this).call(
            abi.encodeWithSelector(this.add.selector, x, y)
        );
        require(success, "Failed to call");
        return abi.decode(data, (uint));
    }

    // function select(uint x, uint y) public returns (uint) {
    //     (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(getSelector));
    // }
}








// 作业题目
// 题目描述：
// 请编写一个 Solidity 智能合约，该合约包含以下功能：

// 函数选择器动态调用：合约中有两个函数 square(uint x) 和 double(uint x)，分别返回输入值的平方和两倍。实现一个名为 executeFunction(bytes4 selector, uint x) 的函数，该函数可以根据传入的选择器动态调用 square 或 double。

// 选择器存储与调用：合约中有一个状态变量 bytes4 storedSelector，实现以下功能：

// storeSelector(bytes4 selector)：将选择器存储在状态变量 storedSelector 中。
// executeStoredFunction(uint x)：调用存储在 storedSelector 中的函数，并返回结果。
// 要求：
// 请确保你的合约能够正确处理函数选择器，并能够通过不同的选择器实现函数调用的动态性。
// 需要考虑到可能的失败场景，例如未设置选择器时调用 executeStoredFunction。
// 提交内容：
// 请提交你的完整合约代码，以及在 Remix 或其他开发环境中对其进行测试的截图。
// 代码需包含注释，解释关键部分的实现思路。

contract Homework {
    bytes4 storedSelector;
    function storeSelector(bytes4 selector) public {
        storedSelector = selector;
    }

    function executeStoredFunction(uint x) public returns (uint) {
        require(storedSelector != 0, "Selector not set");
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(storedSelector, x));
        require(success, "Failed to call");
        return abi.decode(data, (uint));
    }

    function square(uint x) public pure returns (uint) {
        return x * x;
    }

    function double(uint x) public pure returns (uint) {
        return x * 2;
    }

    function executeFunction(bytes4 selector, uint x) public returns (uint) {
        (bool success, bytes memory data) = address(this).call(abi.encodeWithSelector(selector, x));
        require(success, "Failed to call");
        return abi.decode(data, (uint));
    }
}











