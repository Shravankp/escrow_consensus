A system to manage funds based on consensus
Escrow mechanism executed based on consensus fullfillment

A system where in ministry can lock in funds in smart contracts and the amount is released in stages:
initial amount to buy supplies
amount based on proposed product receipts
final amount upon completion

Finance department/admin can lock-in a portion of tax collected to these contracts to address the issues where governance needs to be done based on the public votes

Usecase:
Traceability: People can get accountability on the taxes they pay
This system should act as an enhancer for governance not as a replacer
Frequent voting on pressing issues can be done easily which make sures the opinions of people are heard
This is not a decision making system put in the hands of people, it is merely a vocal and traceable system to enhance governance
This system need not apply only for politics this can be used for governance in any large system be it private or public

Assumptions/Improvements:
We assume every aadhaar number input is right and valid
We store the proposal as a string which can be stored as a doc link

Entities:
Admins/supervisors with special powers who get a percentage of released amount for taking responsibility or supervising)
Executors
People

Mechanisms:
Voting
Releasing the funds to the executors upon fullfillment
Distribution of tokens that represents vote, based on aadhaar number (map every aadhaar with a wallet address)



Functions:

AdminsFuncs:
Create proposals - description, stages, status, allocated_amount, executors, deadline
Change the proposal details based on the votes
Locking in collected Tax Funds by admins (by IT department)

Executors:
Update the status of each stages and get approval from people

People:
Voting for different proposals

 
