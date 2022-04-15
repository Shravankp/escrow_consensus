// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "./voting.sol";
import "./escrow.sol";

//add console.logs to all functions

contract Governance is Ownable {

  enum Status {proposalCreated, executorsAllocated, amountAllocated, calledForVote, votingClosed, resultDeclared, fundsReverted, fundsReleased}
  
  struct Proposal {
    string proposalName;
    string proposalString;
    uint voteCount;
    address[] executors;
    Status proposalStatus;
  }

  Proposal[] public proposals;
  address payable escrow_address;
  address voting_address;
  bool initialised;

  function initialize(address payable _escrow_address, address _voting_address) external onlyOwner  {
      escrow_address = _escrow_address;
      voting_address = _voting_address;
      initialised = true;
  }

  function createProposal(string memory _proposalName, string memory _proposalString) external onlyOwner returns(uint) {
    require(initialised == true, "not initialized");
    Proposal memory proposal;
    proposal.proposalName = _proposalName;
    proposal.proposalString = _proposalString;
    proposal.proposalStatus = Status.proposalCreated;
    proposals.push(proposal);
    uint proposal_id = proposals.length - 1;
    return proposal_id;
  }

  function allocateExecutors(uint _proposalId, address[] memory _addresses) external view onlyOwner {
    Proposal memory proposal = proposals[_proposalId];
    require(proposal.proposalStatus == Status.proposalCreated, "proposal not created with this id");
    proposal.executors = _addresses;
    proposal.proposalStatus = Status.executorsAllocated;
  }

  function allocateAmount(uint _proposalId) external payable onlyOwner{
    Proposal memory proposal = proposals[_proposalId];
    require(proposal.proposalStatus == Status.executorsAllocated, "executors not allocated yet");
    // (bool success, ) = escrow_address.call{value: msg.value}("");
    // require(success, "Transfer failed.");
    Escrow escrow = Escrow(escrow_address);
    console.log("before addFunds balance", this.getBalance());
    escrow.addFunds{value: msg.value}(_proposalId);
    console.log("after addFunds balance", this.getBalance());
    proposal.proposalStatus = Status.amountAllocated;
  }

  function callForVoting() public {
    //change proposal status to callForVoting so that people will be able to vote
  }

  function getListOfProposalsToVote() public {
  }

  function updateProposalStatus() public view {
    console.log("working fine");
  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }

  function contractAddress() public view returns (address) {
    return address(this);
  }

  //if proposal didn't meet the voting majority then send the amount back to ministry
}
