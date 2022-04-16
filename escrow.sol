// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Escrow is Ownable {
  mapping(uint => uint) proposalId_to_amount;

  function addFunds(uint _proposal_id) external payable onlyOwner{
    proposalId_to_amount[_proposal_id] = msg.value;
  }

  function sendFundsToExecutors(uint _proposal_id, address payable[] memory _executors) external payable onlyOwner {
    uint total_amount = proposalId_to_amount[_proposal_id] - 2; //subtract 2 to accomodate for all gas consumption
    uint executors_len = _executors.length;
    uint fractional_amount = total_amount / executors_len;

    for (uint256 i = 0; i < executors_len; i++){
      (bool success, ) = _executors[i].call{value: fractional_amount}("");
      require(success, "transfer of funds to recipients failed");
    }
  }

  function revertFunds(uint _proposal_id) external payable onlyOwner{
    uint total_amount = proposalId_to_amount[_proposal_id] - 2; //subtract 2 to accomodate for all gas consumption
    (bool success, ) = msg.sender.call{value: total_amount}("");
    require(success, "transfer of funds back to governance failed");
  }

  function getEscrowBalanceForProposal(uint _proposal_id) external view returns(uint) {
    return proposalId_to_amount[_proposal_id];
  }
 
  // receive() external payable {
  //     console.log("Amount sent without valid fallback function");
  // }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }
}










