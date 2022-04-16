// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "./voting.sol";
import "./escrow.sol";

contract Governance is Ownable {

  enum Status {proposalCreated, executorsAllocated, amountAllocated, resultDeclared, fundsReverted, fundsReleased}
  
  struct Proposal {
    string proposalName;
    string proposalString;
    address[] executors;
    Status proposalStatus;
    bool approved;
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

  function createProposal(string memory _proposalName, string memory _proposalString, uint minTotalVotesToClose) external onlyOwner returns(uint) {
    require(initialised, "not initialized");
    Proposal memory proposal;
    proposal.proposalName = _proposalName;
    proposal.proposalString = _proposalString;
    proposal.proposalStatus = Status.proposalCreated;
    proposals.push(proposal);
    uint proposal_id = proposals.length - 1;
    console.log("proposal id: ", proposal_id);

    Voting voting = Voting(voting_address);
    voting.initialize(proposal_id, minTotalVotesToClose);
    return proposal_id;
  }

  function allocateExecutors(uint _proposalId, address[] memory _addresses) external onlyOwner {
    Proposal storage proposal = proposals[_proposalId];
    require(proposal.proposalStatus == Status.proposalCreated, "proposal not created with this id");
    proposal.executors = _addresses;
    proposal.proposalStatus = Status.executorsAllocated;
  }

  function allocateAmount(uint _proposalId) external payable onlyOwner{
    Proposal storage proposal = proposals[_proposalId];
    require(proposal.proposalStatus == Status.executorsAllocated, "executors not allocated yet");
    Escrow escrow = Escrow(escrow_address);
    console.log("before addFunds balance", this.getBalance());
    escrow.addFunds{value: msg.value}(_proposalId);
    console.log("after addFunds balance", this.getBalance());
    proposal.proposalStatus = Status.amountAllocated;
  }

  function getVotingResult(uint _proposal_id) public returns (bool) {

  }

  //if proposal didn't meet the voting majority then send the amount back to ministry

  function getListOfProposalsToVote() public view onlyOwner returns(Proposal[] memory){
    return proposals;
  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }

  function contractAddress() public view returns (address) {
    return address(this);
  }

  function getProposalStatus(uint _proposal_id) public view returns (Proposal memory) {
    return proposals[_proposal_id];
  }
}
