// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool);
}

contract IERC165Base is IERC165 {
    mapping(bytes4 => bool) internal _supportedInterfaces;
    constructor() {
        _registerInterface(type(IERC165).interfaceId);
    }

    function supportsInterface(bytes4 interfaceId) public view override returns (bool) {
        return _supportedInterfaces[interfaceId];
    }


    function _registerInterface(bytes4 interfaceId) internal {
        require(interfaceId != 0xffffffff, "ERC165: invalid interface id");
        _supportedInterfaces[interfaceId] = true;
    }
}


// 面试准备问题
// 1. ERC165 的主要作用是什么？

// 回答：ERC165 允许智能合约通过 supportsInterface 函数声明其实现了哪些接口，提供了一种标准化的方式查询合约的功能。
// 2. 如何在 Solidity 中实现 ERC165？

// 回答：可以通过继承 OpenZeppelin 提供的 ERC165 实现，并在合约中注册需要支持的接口 ID。
// 3. 为什么 ERC165 的接口查询需要限制在 30,000 Gas 以内？

// 回答：这样设计是为了确保合约的接口查询不会消耗过多资源，保证网络性能不受影响。