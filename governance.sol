// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
import "./voting.sol";
import "./escrow.sol";

contract Governance is Ownable {

  enum Status {proposalCreated, executorsAllocated, amountAllocated, votingClosed, resultDeclared, fundsReverted, fundsReleased}
  
  struct Proposal {
    string proposalName;
    string proposalString;
    address payable [] executors;
    Status proposalStatus;
    bool approved;
  }

  Proposal[] public proposals;
  address payable escrow_address;
  address voting_address;
  bool initialised;

  function initialize(address payable _escrow_address, address _voting_address) external onlyOwner {
      escrow_address = _escrow_address;
      voting_address = _voting_address;
      initialised = true;
  }

  function createProposal(string memory _proposalName, string memory _proposalString, uint minTotalVotesToClose) external onlyOwner returns(uint) {
    require(initialised, "not initialized");
    Proposal memory proposal = Proposal(_proposalName, _proposalString, new address payable [](0), Status.proposalCreated, false);
    proposals.push(proposal);
    uint proposal_id = proposals.length - 1;
    
    console.log("proposal id: ", proposal_id);
    Voting voting = Voting(voting_address);
    voting.initialize(proposal_id, minTotalVotesToClose);
    return proposal_id;
  }

  function allocateExecutors(uint _proposal_id, address payable[] memory _addresses) external onlyOwner {
    Proposal storage proposal = proposals[_proposal_id];
    require(proposal.proposalStatus == Status.proposalCreated, "proposal not created with this id");
    proposal.executors = _addresses;
    proposal.proposalStatus = Status.executorsAllocated;
  }

  function allocateAmount(uint _proposal_id) external payable onlyOwner{
    Proposal storage proposal = proposals[_proposal_id];
    require(proposal.proposalStatus == Status.executorsAllocated, "executors not allocated yet");

    Escrow escrow = Escrow(escrow_address);
    console.log("before addFunds balance", this.getBalance());
    escrow.addFunds{value: msg.value}(_proposal_id);
    console.log("after addFunds balance", this.getBalance());

    proposal.proposalStatus = Status.amountAllocated;
  }

  function closeVoting(uint _proposal_id) external onlyOwner{
    Proposal storage proposal = proposals[_proposal_id];
    require(proposal.proposalStatus == Status.amountAllocated, "amount not allocated yet");
    proposal.proposalStatus = Status.votingClosed;
  }

  function getVotingResult(uint _proposal_id) public onlyOwner returns (bool) {
    Proposal storage proposal = proposals[_proposal_id];
    require(proposal.proposalStatus == Status.votingClosed, "voting not closed yet");
    
    Voting voting = Voting(voting_address);
    bool won = voting.getIfProposolApproved(_proposal_id);

    proposal.proposalStatus = Status.resultDeclared;
    if (won) {
       proposal.approved = true;
    }
    return won;
  }

  function releaseFunds(uint _proposal_id) public onlyOwner {
    Proposal storage proposal = proposals[_proposal_id];
    Escrow escrow = Escrow(escrow_address);
    if (proposal.approved) {
      escrow.sendFundsToExecutors(_proposal_id, proposal.executors);
      proposal.proposalStatus = Status.fundsReleased;
    } else {
      escrow.revertFunds(_proposal_id);
      proposal.proposalStatus = Status.fundsReverted;
    }
  }

  function getAllProposals() public view returns(Proposal[] memory){
    return proposals;
  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }

  function contractAddress() public view returns (address) {
    return address(this);
  }
}
