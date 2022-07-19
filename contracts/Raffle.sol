// Create raffle contract
// Enter the lottery by paying some ammount
// Pick a random winner (ver random)
// Winner to be selected every X minutes --> completely automated
// Chainlink Oracle -> Randomness, Automated Execution (Chainlink keepers)

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

//Error codes
error Raffle__NotEnoughETHEntered();

contract Raffle {
    /* State Variables */
    uint256 private immutable i_entranceFee;
    //making immutable to save gas
    address payable[] private s_players;

    /* Events */
    //Named events with the function name reversed
    event RaffleEnter(address indexed player);

    constructor(uint256 entranceFee) {
        i_entranceFee = entranceFee;
    }

    function enterRaffle() public payable {
        //require msg.value > i_entranceFee
        //Adding custom error code is more gas efficient
        if (msg.value < i_entranceFee) {
            revert Raffle__NotEnoughETHEntered();
        }
        s_players.push(payable(msg.sender));
        //Send event
        emit RaffleEnter(msg.sender);
    }

    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }

    function getPlayer(uint256 index) public view returns (address) {
        return s_players[index];
    }

    // function pickRandomWinner(){

    // }
}
