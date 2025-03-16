// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;


// 任务 1：基于映射创建一个简单的用户余额管理系统，并实现余额的增加与查询功能。
// 任务 2：扩展系统，使其能够记录每个用户的交易历史，模拟 Java 的 Map 中键集合的概念。
// 任务 3：结合映射与数组，实现一个简单的排行榜系统，记录并排序用户的积分。

contract MappingContract {
    mapping(address => uint256) public balances;
    mapping(address => uint256[]) public history;

    function checkBalance() public view returns (uint) {
        return balances[msg.sender];
    }

    function deposit() public payable {
        require(msg.value > 0, "Deposit value must be greater than 0");
        balances[msg.sender] += msg.value;
        history[msg.sender].push(msg.value);
    }

    function checkHistory() public view returns (uint[] memory) {
        return history[msg.sender];
    }


 
    
}