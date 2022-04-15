// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Escrow is Ownable {
  uint allocated_amount;
  bytes proposal_name;
  mapping(uint => uint) proposalId_to_amount;

  function addFunds(uint proposal_id) external payable onlyOwner{
      proposalId_to_amount[proposal_id] = msg.value;
  }

  function releaseFunds() external view {}
  function revertFunds() external view {} //back to governance

  function getEscrowBalanceForProposal(uint proposal_id) external view returns(uint) {
    return proposalId_to_amount[proposal_id];
  }
 
  receive() external payable {
      console.log("Amount sent without valid fallback function");
  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }
}










