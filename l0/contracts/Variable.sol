// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

// 状态变量： 存储到合约的存储空间  永久有效
contract Variable {
    uint storageData;  
    constructor() public {
        storageData = 10;
    }

    function getResult() public view returns (uint) {
        uint a = 1;
        // address b; 
        uint c = 2;

        return a + c;
    }



    // block.blockhash

}
