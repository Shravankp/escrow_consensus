// SPDX-License-Identifier: MIT
pragma solidity ^0.8.2;

import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";

contract Voting is Ownable {

  mapping(uint => address) internal walletAadhaarMapping;

  function giveVote(string memory proposalName) public {
    
  }

  function votingLogic() public {
    //uint minimumVotesRequired;
    //uint minPositiveVotesRequired;
  }

  function getResults() public {
    
  }

  function votingDetails() public {
    //total no of votes
    
  }
}