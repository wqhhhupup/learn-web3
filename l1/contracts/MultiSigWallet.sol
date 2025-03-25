// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

// 部署时候传入地址参数和需要的签名数
// 多个 owner 地址
// 发起交易的最低签名数
// 有接受 ETH 主币的方法，
// 除了存款外，其他所有方法都需要 owner 地址才可以触发
// 发送前需要检测是否获得了足够的签名数
// 使用发出的交易数量值作为签名的凭据 ID（类似上么）
// 每次修改状态变量都需要抛出事件
// 允许批准的交易，在没有真正执行前取消。
// 足够数量的 approve 后，才允许真正执行。

contract MultiSigWallet {
    address[] public owners;
    uint public required;
    mapping(address => bool) public isOwner;
    mapping(uint => mapping(address => bool)) public approvals;

    struct Transaction {
        address to;
        uint value;
        bool executed;
        bytes data;
    }

    Transaction[] public transactions;

    event Deposit(address indexed sender, uint value);
    event Submit(uint indexed txIndex);
    event Execute(uint indexed txIndex);
    event Approval(uint indexed txIndex, address indexed owner);
    event Revoke(uint indexed txIndex, address indexed owner);  

    constructor(address[] memory _owners, uint _required) {
        require(_owners.length > 0, "owners required");
        require(
            _required > 0 && _required <= _owners.length,
            "required should be between 1 and owners.length"
        );
        for (uint i = 0; i < _owners.length; i++) {
            address owner = _owners[i];
            require(owner != address(0), "invalid owner");
            require(!isOwner[owner], "owner not unique");
            isOwner[owner] = true;
            owners.push(owner);
        }
    }

    modifier onlyOwner() {
        require(isOwner[msg.sender], "not owner");
        _;
    }

    modifier txExists(uint _txIndex) {
        require(_txIndex < transactions.length, "tx does not exist");
        _;
    }

    modifier notExecuted(uint _txIndex) {
        require(!transactions[_txIndex].executed, "tx already executed");
        _;
    }

    modifier notApproved(uint _txIndex) {
        require(!approvals[_txIndex][msg.sender], "tx already approved");
        _;
    }

    function approved(
        uint _txIndex
    )
        public
        onlyOwner
        txExists(_txIndex)
        notExecuted(_txIndex)
        notApproved(_txIndex)
    {
        approvals[_txIndex][msg.sender] = true;
        emit Approval(_txIndex, msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    function submitTransaction(
        address _to,
        uint _value,
        bytes calldata _data
    ) public onlyOwner {
        transactions.push(
            Transaction({to: _to, value: _value, executed: false, data: _data})
        );
        emit Submit(transactions.length - 1);
    }

    function excuteTransaction(
        uint _txIndex
    ) public onlyOwner txExists(_txIndex) notExecuted(_txIndex) {
        Transaction storage transaction = transactions[_txIndex];
        require(!transaction.executed, "transaction already executed");
        transaction.executed = true;
        (bool success, ) = transaction.to.call{value: transaction.value}(
            transaction.data
        );
        require(success, "transaction failed");
        emit Execute(_txIndex);
    }

    function getApprovals(uint _txIndex) public view returns (uint) {
        uint count = 0;
        for (uint i = 0; i < owners.length; i++) {
            if (approvals[_txIndex][owners[i]]) {
                count += 1;
            }
        }
        return count;
    }
    function revokeApproval(uint _txIndex) public {
        approvals[_txIndex][msg.sender] = false;
        emit Revoke(_txIndex, msg.sender);

    }
}
