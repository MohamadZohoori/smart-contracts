// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ReputationSystem {
    struct User {
        uint256 id;
        string name;
        uint256 reputationScore;
    }

    uint256 public userCount;
    mapping(address => User) public users;

    event UserRegistered(uint256 id, address user, string name);
    event ReputationUpdated(address user, uint256 reputationScore, string comment);

    function registerUser(string memory _name) public {
        require(bytes(_name).length > 0, "Name cannot be empty");

        userCount++;

        users[msg.sender] = User({
            id: userCount,
            name: _name,
            reputationScore: 0
        });

        emit UserRegistered(userCount, msg.sender, _name);
    }

    function updateReputation(address _user, uint256 _reputationScore, string memory _comment) public {
        require(_user != address(0), "Invalid user address");
        require(_reputationScore >= 0, "Reputation score must be non-negative");

        users[_user].reputationScore += _reputationScore;

        emit ReputationUpdated(_user, users[_user].reputationScore, _comment);
    }

    function getUser(address _user) public view returns (
        uint256 id,
        string memory name,
        uint256 reputationScore
    ) {
        require(_user != address(0), "Invalid user address");
        User storage user = users[_user];

        return (
            user.id,
            user.name,
            user.reputationScore
        );
    }
}