// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;
contract Hello {
    function sayHi() public {}

    receive() external payable {}

    function returnAddress() public view returns (address) {
        return address(this);
    }

    function destroy(address payable recipient) public {
        selfdestruct(recipient); // 销毁合约发送剩余的以太币给指定地址

        //  Cancun 硬分叉后，selfdestruct 不会删除代码和数据，只会转移余额。
        // EIP-6780 修改了 selfdestruct 逻辑，未来可能进一步限制该操作码。
        // 新合约不应该使用 selfdestruct，可以用状态变量+访问控制来停用合约。
    }

    // type 获取合约信息

    function getContractInfo() public pure returns (string memory, bytes memory, bytes memory) {
        return (type(Hello).name, "", "");
    }


    function isContractAdress(address _addr) public view returns (bool) {
        uint32 size;
        assembly {
            size := extcodesize(_addr)
        }
        return (size > 0);
    }
    
}
