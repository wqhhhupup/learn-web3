// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract AddressTest {
    mapping(address => uint256) public balances;

    function checkBalance() public view returns (uint256) {
        return balances[msg.sender];
    }

    function withdraw(uint256 _amount) public {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        (bool success, ) = msg.sender.call{value: _amount}("");
        require(success, "Transfer failed");
    }

    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
}
