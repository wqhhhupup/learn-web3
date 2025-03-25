// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

// WETH 是包装 ETH 主币，作为 ERC20 的合约。 标准的 ERC20 合约包括如下几个

// 3 个查询
// balanceOf: 查询指定地址的 Token 数量
// allowance: 查询指定地址对另外一个地址的剩余授权额度
// totalSupply: 查询当前合约的 Token 总量
// 2 个交易
// transfer: 从当前调用者地址发送指定数量的 Token 到指定地址。
// 这是一个写入方法，所以还会抛出一个 Transfer 事件。
// transferFrom: 当向另外一个合约地址存款时，对方合约必须调用 transferFrom 才可以把 Token 拿到它自己的合约中。
// 2 个事件
// Transfer
// Approval
// 1 个授权
// approve: 授权指定地址可以操作调用者的最大 Token 数量。

contract WETH {
    string public name = "Wrapped Ether";
    string public symbol = "WETH";
    uint8 public decimals = 18;

    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    event Transfer(address indexed from, address indexed to, uint value);
    event Approval(address indexed owner, address indexed spender, uint value);

    function transfer(address to, uint value) public {
        require(balanceOf[msg.sender] >= value, "Not enough balance");

        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
    }

    function totalSupply() public view returns (uint) {
        return address(this).balance;
    }

    function transferFrom(address from, address to, uint value) public {
        require(balanceOf[from] >= value, "Not enough balance");
        require(allowance[from][msg.sender] >= value, "Not enough allowance");

        balanceOf[from] -= value;
        balanceOf[to] += value;

        allowance[from][msg.sender] -= value;

        emit transfer(from, to, value);
    }

    function approve(address owner,address spender, uint value) public {
        allowance[owner][spender] = value;
        emit Approval(owner, spender, value);
    }
}
