// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;



// 无法继承其他合约或接口：接口不能扩展其他合约或接口。
// 无法定义构造函数：接口不允许定义任何构造函数，因为它不能有内部状态。
// 无法定义状态变量：接口不能有状态变量，因为它不存储数据。
// 无法定义结构体或枚举：接口不能包含结构体或枚举。
// 接口的语法

interface IVault {
    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;
}


contract Bank is IVault {
    mapping(address => uint256) public balances;

    function deposit(uint256 amount) public override {
        balances[msg.sender] += amount;
    }

    function withdraw(uint256 amount) public override {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] -= amount;
    }
}