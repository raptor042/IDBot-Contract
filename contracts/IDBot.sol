// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Profile.sol";

contract IDBot {
    address owner;

    address[] public _profiles;

    mapping (string => address) public profiles;

    struct Subscription {
        address account;
        uint256 duration;
        uint256 startedAt;
        bool isActive;
    }

    Subscription[] public _subscribers;

    mapping (address => Subscription) public subscribers;

    event CreateProfile(address indexed profile, address indexed owner, string profileId);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Not Authorized.");
        _;
    }

    function createProfile(
        string memory _name,
        string memory _description,
        bool _dev,
        string memory _email,
        uint256 _age,
        string memory phone,
        string memory _country,
        string memory _state,
        string memory _address,
        string memory url,
        address _owner,
        string memory _hash
    ) public onlyOwner {
        Profile profile = new Profile(
            _name,
            _description,
            _dev,
            _email,
            _age,
            phone,
            _country,
            _state,
            _address,
            url,
            _owner
        );

        string memory profileId = string(abi.encodePacked(
            "did-IDBot-",
            _hash,
            "#",
            block.timestamp
        ));

        _profiles.push(address(profile));

        profiles[profileId] = address(profile);

        emit CreateProfile(address(profile), _owner, profileId);
    }

    function subscribe(address _account, uint256 _duration) public onlyOwner {
        if(isSubscribed(_account)) {
            updateSubscription(_account, _duration);
        } else {
            Subscription memory subscription = Subscription({
                account : _account,
                duration : _duration,
                startedAt : block.timestamp,
                isActive : true
            });

            for (uint i = 0; i < _profiles.length; i++) {
                Profile profile = Profile(_profiles[i]);

                profile.addAccountToAccessList(_account);
            }

            _subscribers.push(subscription);

            subscribers[_account] = subscription;
        }
    }

    function unsubscribe() public onlyOwner {
        for (uint i = 0; i < _subscribers.length; i++) {
            Subscription storage subscriber = _subscribers[i];
            uint256 timeElapsed = (block.timestamp - subscriber.startedAt) / 86400;

            if(timeElapsed >= subscriber.duration && subscriber.isActive == true) {
                subscriber.isActive = false;

                for (uint x = 0; x < _profiles.length; x++) {
                    Profile profile = Profile(_profiles[x]);

                    profile.removeAccountFromAccessList(subscriber.account);
                }
            }
        }
    }

    function isSubscribed(address _account) internal view onlyOwner returns (bool subscribed) {
        Subscription memory subscriber = subscribers[_account];

        if(_account == subscriber.account) {
            return true;
        } else {
            return false;
        }
    }

    function updateSubscription(address _account, uint256 _duration) internal onlyOwner {
        Subscription storage subscriber = subscribers[_account];

        if(subscriber.isActive == false) {
            subscriber.isActive = true;
        }

        subscriber.duration = _duration;

        subscriber.startedAt = block.timestamp;
    }
}