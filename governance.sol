// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Governance is ownable {
  struct Proposal {
    bytes32 proposalName;
    //enum proposalStatus;
    bytes proposalString;
    uint voteCount;
    uint completionDate;
    address[] executors;
  }

  mapping(uint => address) public walletAadhaarMapping;
  Proposal[] public proposals;
  
  function createProposal() payable {
    
  }

  function callForVoting() {
    //change proposal status to callForVoting so that people will be able to vote
  }

  function getListOfProposalsToVote() {
    
  }

  function allocateRecipients() {
    
  }
}