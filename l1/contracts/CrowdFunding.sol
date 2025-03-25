// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract CrowdFunding {
    address public immutable beneficiary;
    uint public immutable fundingGoal;
    uint public fundingAmount;
    address[] public fundersKey;

    mapping(address => uint) public funders;

    constructor(address _beneficiary, uint _fundingGoal) {
        beneficiary = _beneficiary;
        fundingGoal = _fundingGoal;
    }

    function fund() public payable {
        require(msg.value > 0, "You need to send some ether");

        uint refundAmount = 0;
        uint currentFundingAmount = fundingAmount + msg.value;

        if (currentFundingAmount > fundingGoal) {
            refundAmount = currentFundingAmount - fundingGoal;
            // funders[msg.sender] += refundAmount;

            if (refundAmount != msg.value) {
                funders[msg.sender] += msg.value - refundAmount;
                fundersKey.push(msg.sender);

                fundingAmount = msg.value - refundAmount;
            }

            if (refundAmount > 0) {
                payable(msg.sender).transfer(refundAmount);
            }
        } else {
            funders[msg.sender] += msg.value;
            fundersKey.push(msg.sender);
            fundingAmount += msg.value; 
        }
    }

    function getFunders() public view returns (address[] memory) {
        return fundersKey;
    }
}
