// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Governance is ownable {

  enum Status {initialised, executorsAllocated, amountAllocated, calledForVote, votingClosed, resultDeclared, fundsReverted, fundsReleased}
  
  struct Proposal {
    bytes32 proposalName;
    bytes proposalString;
    uint voteCount;
    address[] executors;
    Status proposalStatus;
  }

  Proposal[] public proposals;
  
  function createProposal(bytes32 proposalName, bytes proposalString) {
    
  }

  function allocateAmount() payable{
    //call escrow function
  }

  function callForVoting() {
    //change proposal status to callForVoting so that people will be able to vote
  }

  function getListOfProposalsToVote() {
    
  }

  function allocateRecipients() {
    
  }

  function updateProposalStatus() {
    
  }

  //if proposal didn't meet the voting majority then send the amount back to ministry
}
