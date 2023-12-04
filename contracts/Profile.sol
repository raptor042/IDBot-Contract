// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Profile {
    address owner;

    bool public verified;

    string public name;

    string public email;

    uint256 public age;

    string public phone_number;

    string public profile_pic_url;

    uint256 public reputation_score;

    struct Project {
        string name;
    }

    Project[] public _projects;

    mapping (string => Project) public projects;

    constructor(
        string memory _name,
        string memory _email,
        uint256 _age,
        string memory phone,
        string memory url,
        address _owner
    ) {
        name = _name;

        email = _email;

        age = _age;

        phone_number = phone;

        profile_pic_url = url;

        reputation_score = 0;

        owner = _owner;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }
}