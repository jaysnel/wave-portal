// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalWaves;

    event NewWave(address indexed from, uint256 timestamp, string message, string username);

    struct Wave {
        address waver;
        string message;
        uint256 timestamp;
        string username;
    }

    Wave[] waves;

    constructor() payable {
        console.log("Smart contract made payable");
    }

    function wave(string memory _message, string memory _username) public {
        totalWaves += 1;
        console.log('%s has waved: ', msg.sender, _message);

        waves.push(Wave(msg.sender, _message, block.timestamp, _username));

        emit NewWave(msg.sender, block.timestamp, _message, _username);

        // Need to work on way to show user messages
        // uint256 prizeAmount = 0.0001 ether;
        // require(
        //     prizeAmount <= address(this).balance,
        //     'Trying to withdraw more money than the contract has.'
        // );
        // (bool success, ) = (msg.sender).call{value: prizeAmount}('');
        // require(success, 'Failed to withdraw money from contract.');
    }

    function getAllWaves() public view returns (Wave[] memory) {
        return waves;
    }

    function getTotalWaves() public view returns (uint256) {
        console.log('We have %d total waves!', totalWaves);
        return totalWaves;
    }
}