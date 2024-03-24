# Voting Contract Using Forge | Foundry

This is a simple voting contract written in Solidity. It allows members of the contract to create proposals and vote on them. A proposal is executed when it reaches a certain threshold of 'Yes' votes.

## How it works

1. **Members**: The contract keeps track of its members. Only members can create proposals and vote.

2. **Proposals**: A proposal contains the address of a target contract, data to be passed to that contract, a flag indicating whether the proposal has been executed, and counts of 'Yes' and 'No' votes.

3. **Voting**: Members can vote 'Yes' or 'No' on proposals. The contract keeps track of each member's vote. If a member changes their vote, the contract updates the vote counts accordingly.

4. **Execution**: When a proposal gets 10 'Yes' votes, the contract tries to execute it. This involves calling a function on the target contract with the provided data. A proposal can only be executed once.

## Events

The contract emits events when a new proposal is created and when a vote is cast. These can be used to track the contract's activity.

## Running on the Blockchain

When this contract is deployed to the blockchain, it starts with a list of members. These members can then interact with the contract by creating proposals and voting. The contract's state, including all proposals and votes, is stored on the blockchain. This means it's transparent and can't be tampered with.

When a proposal is executed, the contract makes a transaction to the target contract. This transaction is also recorded on the blockchain.

Remember, as with all blockchain transactions, interactions with this contract require gas, which is paid in Ether if depolyed on ethereum blockchain.

# Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/