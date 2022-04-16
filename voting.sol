// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Voting is Ownable {

  struct VoteDetails{
    uint totalVotes;
    uint votedForCount;
    uint votedAgaintCount;
    uint minTotalVotesToClose;
  }

  mapping(address => mapping(uint => bool)) internal address_to_proposalIdArr;
  mapping(uint => VoteDetails) internal proposalId_to_voteDetails;
  // mapping(uint => address) internal aadhaar_to_walletAddress;
  // VoteDetails[] internal vDetailsArr;

  function initialize(uint _proposal_id, uint _minTotalVotesToClose) external onlyOwner{
    // vDetailsArr.push(VoteDetails(0, 0, 0, _minTotalVotesToClose));
    // uint vDetailsArrIdx = vDetailsArr.length - 1;
    proposalId_to_voteDetails[_proposal_id] = VoteDetails(0, 0, 0, _minTotalVotesToClose);
  }

  function giveVote(uint _proposal_id, bool _voteDecision, address _address) external {
    require(address_to_proposalIdArr[_address][_proposal_id] == false, "you have already voted for this proposal");
    address_to_proposalIdArr[_address][_proposal_id] = true;

    VoteDetails storage vDetail = proposalId_to_voteDetails[_proposal_id];
    vDetail.totalVotes += 1;
    if (_voteDecision) {
      vDetail.votedForCount += 1;
    } else {
      vDetail.votedAgaintCount += 1;
    }
  }

  function votingLogic() internal onlyOwner {

  }

  function getResults(uint _proposal_id) external onlyOwner returns(bool){
    //check if total votes >= minVotes
    // 
    
  }

  function getVotingDetails(uint _proposal_id) external view returns(VoteDetails memory) {
    return proposalId_to_voteDetails[_proposal_id];
  }
}