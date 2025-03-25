// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

// 所有人都可以存钱
// ETH
// 只有合约 owner 才可以取钱
// 只要取钱，合约就销毁掉 selfdestruct

contract Bank {
    address immutable owner;

    constructor() {
        owner = msg.sender;
    }

    event Deposit(address indexed _from, uint _amount);
    event Withdraw(address indexed _to, uint _amount);

    function deposit() public payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint _amount) public {
        require(msg.sender == owner, "only owner can withdraw");
        emit Withdraw(msg.sender, _amount);
        selfdestruct(payable(msg.sender));
    }
}
