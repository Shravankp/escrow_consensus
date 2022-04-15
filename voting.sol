// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Voting is ownable {

  mapping(uint => address) internal walletAadhaarMapping;

  function giveVote(proposalName) {
    
  }

  function votingLogic() {
    //uint minimumVotesRequired;
    //uint minPositiveVotesRequired;
  }

  function getResults(){
    
  }

  function votingDetails(){
    //total no of votes
    
  }
}