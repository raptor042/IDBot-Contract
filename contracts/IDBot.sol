// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Profile.sol";

contract IDBot {
    mapping (string => address) public profiles;

    event CreateProfile(address indexed profile, address indexed owner, string profileId);

    constructor() {}

    function createProfile(
        string memory _name,
        string memory _email,
        uint256 _age,
        string memory phone,
        string memory url,
        address _owner
    ) external {
        Profile profile = new Profile(
            _name,
            _email,
           _age,
            phone,
            url,
            _owner
        );

        string memory profileId = string(abi.encodePacked(
            "did-IDBot",
            address(profile),
            "#",
            block.timestamp
        ));

        profiles[profileId] = address(profile);

        emit CreateProfile(address(profile), _owner, profileId);
    }
}