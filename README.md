# Escrow system with consensus fulfilment for better governance

A system where admin can lock in funds in smart contracts and the amount is released upon consensus fullfillment.
This system makes sure, no one not even admin will not be able to manipulate voting data and cannot posses any control on funds unless approved by consensus

- This system solves for biases related to voting machine and its management.
- Use blockchain based escrow system instead of 3rd party as a money manager.
- Makes the system traceable, i.e people can get accountability on the funds/taxes they pay.
- Frequent voting on pressing issues can be done easily which make sures the opinions of people/stakeholders are heard.

Eg: 
1. Finance department/admin can lock-in a portion of tax collected to these contracts to address the issues where governance needs to be done based on the public votes.
2. A large company wants to decide if funds to be allocated for a specific cause based on their employee votes.

## Assumptions/Improvements:
- Executors have static roles here, but this can be dynamic with different authoritative power and roles in the system
- Enable admin to change the proposal details based on the votes
- Funds can be released in stages, i.e contract can seek approval from appropriate people after each stage, get pre/initial money & after each stage completion can release full money 
- Voting logic can be made dynamic based on usecases of each proposals
- We assume everyone has only 1 wallet address, but actually 1 member can have multiple accounts, so maybe we can map each aadhaar with 1 wallet address to restrict this
- We store the proposal details as a string here which can be stored in a better way maybe as a doc link
- Add events whenever there is a state change so that can be shown on frontend

## System design:
Entities:
- Admins/supervisors
- Executors (everyone involved in execution of proposal who act as recipients of the fund)
- Voters

steps involved:
- admin deploys the code thereby becomes the owner of governance contract
- make governance contract the owner of escrow and voting
- admin will createProposal with required details
- admin locks-in the funds
- admin will add executors/recipients
- admin calls for voting
- people/stakeholders vote for or against the proposal
- voting closes and result is declared
- based on result, either the fund is transferred to recipients or reverted to governance contract


### execution flow
- make governance.sol owner of escrow.sol & voting.sol
- initialize
- createProposal
- allocateExecutors
- allocateAmount
- giveVote (voting.sol)
- closeVoting
- getVotingResult
- releaseFunds
