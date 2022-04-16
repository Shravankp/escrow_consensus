# Escrow system to manage funds with consensus
Escrow mechanism executed based on consensus fullfillment

A system where admin can lock in funds in smart contracts and the amount is released upon consensus fullfillment:
initial amount to buy supplies
amount based on proposed product receipts
final amount upon completion

Eg: Finance department/admin can lock-in a portion of tax collected to these contracts to address the issues where governance needs to be done based on the public votes

## Usecase:
- Traceability: People can get accountability on the taxes they pay
- This system can act as an enhancer for governance not as a replacer
- Frequent voting on pressing issues can be done easily which make sures the opinions of people/stakeholders are heard
- This is not a decision making system put in the hands of people, it is merely a vocal and traceable system to enhance governance
- This system need not apply only for politics this can be used for governance in any large system be it private or public entities

## Assumptions/Improvements:
- We store the proposal as a string which can be stored as a doc link
- executors have static roles here, but this can be dynamic with different authoritative power and roles in the system
- Enable admin to change the proposal details based on the votes
- Funds can be released in stages, seek for approval from appropriate people after each stage, get pre-money & full money after each stage completion
- Voting logic can be made dynamic based on usecases of each proposals
- Add events whenever there is a state change so that can be shown on frontend
- We assume everyone has only 1 wallet address, but actually 1 member can have multiple accounts, so maybe we can map each aadhaar with 1 wallet address to restrict this

## System design:
Entities:
- Admins/supervisors with special powers for supervising
- Executors (builders, suppliers, employees - everyone involved for execution of proposal)
- People

Mechanisms:
- Distribution of tokens that represents vote, based on aadhaar number (map every aadhaar with a wallet address)
- Voting
- Releasing the funds to the executors upon fullfillment


Functions:

AdminsFuncs:
Create proposals - description, stages, status, allocated_amount, executors, deadline
Locking in collected Tax Funds by admins (by IT department)

Executors:
Update the status of each stages and get approval from people

People:
Voting for different proposals

 

steps involved:
- admin deploys the code
- admin becomes the owner of all three contracts
- admin is the owner of governance.sol and governance is the owner of escrow.sol and voting.sol
- admin will createProposal with required details
- admin can lock-in the amount
- admin will add executors/recipients - executors should already been registered before admin adds i.e we need aadhaar-to-address mapping
- executor gets some money before initial phase
- executor updates the status and seeks for approval from admins
- once all stages are complete the money is released proportionately to executors/ministers

Things to make sure:
- admin should not be able to manipulate voting data
- admin should not have any control on funds unless approved by consensus




