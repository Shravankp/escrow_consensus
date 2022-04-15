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

  function createProposal(bytes32 _proposalName, bytes memory _proposalString) external onlyOwner returns(uint) {
    uint id = proposals.push(Proposal({proposalName: _proposalName, 
                                      proposalString: _proposalString,
                                      proposalStatus: Status.initialised})) - 1;
    return id;
  }

  function allocateExecutors(bytes32 _proposalId, address[] memory _addresses) external onlyOwner {
    Proposal proposal = proposals[_proposalId];
    require(proposal.proposalStatus == Status.initialised);
    proposal.executors = _addresses;
  }

  function allocateAmount(bytes32 _proposalId) external payable{
    Proposal proposal = proposals[_proposalId];
    require(proposal.proposalStatus == Status.executorsAllocated);
    uint amountToAllocate = msg.value;
    //todo: call escrow function that assigns amountToAllocate to a state variable
    //escrow can have proposal_id to amount mapping
  }

  function callForVoting() {
    //change proposal status to callForVoting so that people will be able to vote
  }

  function getListOfProposalsToVote() {
    
  }



  function updateProposalStatus() {
    
  }

  //if proposal didn't meet the voting majority then send the amount back to ministry
}
