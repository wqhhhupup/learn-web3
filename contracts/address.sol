// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract AddressType {
    mapping(address => bool) whitelist;
    address public myAddress; // 是一个 20 字节（160 位）的值，代表以太坊区块链上的一个账户地址。

    constructor() {
        myAddress = 0x1234567890123456789012345678901234567890; // 赋值给 myAddress
    }

    // 获取调用合约的地址
    address myAddress2 = msg.sender; // 当前合约调用者的地址

    // 将 myAddress 转换为可支付地址
    address payable payableAddress = payable(myAddress);
    // 获取 myAddress 的余额
    uint256 balance = myAddress.balance; // 注意：应在函数内使用此行
    // 创建一个可支付地址的接收者
    address payable recipient = payable(myAddress);

    // 转账 1 ether
    function transferEther() public {
        (bool success, ) = recipient.call{value: 1 ether}("");
        require(success, "Transfer failed");
    }

    function addWhitelist(address _add) public {
        whitelist[_add] = true;
    }

    function isWhitelist(address _add) public view returns (bool) {
        return whitelist[_add];
    }

    function pay(address payable rec) public payable {
        require(isWhitelist(rec), "You are not in whitelist");
        (bool success, ) = rec.call{value: 1 ether}("");
        require(success, "Transfer failed");
    }
}
