// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract Faucet {
    uint public cooldown;
    uint256 public fundAmount;
    address private owner;
    mapping(address => uint) public beggarToLatestFundedTimestamp;

    constructor(address _owner, uint _cooldown, uint256 _fundAmount) payable {
        cooldown = _cooldown;
        fundAmount = _fundAmount;
        owner = _owner;
    }

    receive() external payable {}

    function setCooldown(uint _cooldown) public {
        require(msg.sender == owner, "Only owner can set cooldown");
        cooldown = _cooldown;
    }

    function setFundAmount(uint256 _fundAmount) public {
        require(msg.sender == owner, "Only owner can set fund amount");
        fundAmount = _fundAmount;
    }

    function getFunds(address payable _addressToFund) public {
        require(
            address(this).balance >= fundAmount,
            "faucet does not have enough funds"
        );
        uint lastFundTimestamp = beggarToLatestFundedTimestamp[_addressToFund];
        require(
            block.timestamp >= lastFundTimestamp + cooldown,
            "not enough time passed since last fund"
        );
        beggarToLatestFundedTimestamp[_addressToFund] = block.timestamp;
        bool ok = _addressToFund.send(fundAmount);
        if (!ok) {
            beggarToLatestFundedTimestamp[_addressToFund] = lastFundTimestamp;
        }
        require(ok, "failed to fund address");
    }
}
