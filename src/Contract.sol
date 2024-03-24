// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Voting {
    // Enum to represent different vote states
    enum VoteStates {
        Absent,
        Yes,
        No
    }

    // Constant representing the vote threshold
    uint constant VOTE_THRESHOLD = 10;

    // Struct to represent a proposal
    struct Proposal {
        address target; // Address of the target contract
        bytes data; // Data to be passed to the target contract
        bool executed; // Flag indicating whether the proposal has been executed
        uint yesCount; // Number of "Yes" votes
        uint noCount; // Number of "No" votes
        mapping(address => VoteStates) voteStates; // Mapping to track vote states of members
    }

    // Array to store all proposals
    Proposal[] public proposals;

    // Event emitted when a new proposal is created
    event ProposalCreated(uint);

    // Event emitted when a vote is cast
    event VoteCast(uint, address indexed);

    // Mapping to track members
    mapping(address => bool) members;

    // Constructor to initialize the contract with members
    constructor(address[] memory _members) {
        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
        members[msg.sender] = true;
    }

    // Function to create a new proposal
    function newProposal(address _target, bytes calldata _data) external {
        require(members[msg.sender]); // Only members can create proposals
        emit ProposalCreated(proposals.length);
        Proposal storage proposal = proposals.push();
        proposal.target = _target;
        proposal.data = _data;
    }

    // Function to cast a vote on a proposal
    function castVote(uint _proposalId, bool _supports) external {
        require(members[msg.sender]); // Only members can cast votes
        Proposal storage proposal = proposals[_proposalId];

        // Clear out previous vote
        if (proposal.voteStates[msg.sender] == VoteStates.Yes) {
            proposal.yesCount--;
        }
        if (proposal.voteStates[msg.sender] == VoteStates.No) {
            proposal.noCount--;
        }

        // Add new vote
        if (_supports) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        // Update vote state for the member
        proposal.voteStates[msg.sender] = _supports
            ? VoteStates.Yes
            : VoteStates.No;

        emit VoteCast(_proposalId, msg.sender);

        // Execute the proposal if the vote threshold is reached and it hasn't been executed before
        if (proposal.yesCount == VOTE_THRESHOLD && !proposal.executed) {
            (bool success, ) = proposal.target.call(proposal.data);
            require(success);
        }
    }
}
