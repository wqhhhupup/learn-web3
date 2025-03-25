// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

// 任何人都可以发送金额到合约
// 只有 owner 可以取款
// 3 种取钱方式

contract Wallet {
    address public owner;

    mapping(address => uint) public balances;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can call this function");
        _;
    }

    function withdraw(uint _amount) external onlyOwner {
        require(address(this).balance >= _amount, "insufficient balance");
        payable(owner).transfer(_amount);
    }

    function withdraw1(uint _amount) external onlyOwner {
        require(address(this).balance >= _amount, "insufficient balance");
        bool success = payable(owner).send(_amount);
        require(success, "transfer failed");
    }

    function withdraw2(uint _amount) external onlyOwner {
        require(address(this).balance >= _amount, "insufficient balance");
        (bool success, ) = payable(owner).call{value: _amount}("");
        require(success, "transfer failed");
    }
}
