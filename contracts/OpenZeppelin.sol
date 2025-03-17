// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/contracts/math/SafeMath.sol";

library SafeMath {
    // 加法运算，溢出时抛出异常
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");
        return c;
    }

    // 减法运算，溢出时抛出异常
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b <= a, "SafeMath: subtraction overflow");
        uint256 c = a - b;
        return c;
    }

    // 乘法运算，溢出时抛出异常
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }
        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");
        return c;
    }

    // 除法运算，除 0 异常
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        require(b > 0, "SafeMath: division by zero");
        uint256 c = a / b;
        return c;
    }
}

contract MyContract is Ownable {
    using SafeMath for uint256;
    uint z;

    function add(uint y) public {
        z = z.add(y);
    }
}
