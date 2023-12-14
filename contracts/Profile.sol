// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract Profile {
    address private owner;

    address super_owner;

    bool private verified;

    string private name;

    string private description;

    bool private dev;

    string private email;

    uint256 private age;

    string private phone_number;

    string private country;

    string private state;

    string private residential_address;

    string private profile_pic_url;

    uint256 private reputation_score;

    struct Project {
        string name;
        string description;
        address contract_address;
        string website_link;
        string telegram_link;
        string twitter_link;
        string discord_link;
        string linktree;
        bool isHoneyPot;
        bool isRugged;
        uint256 reputation_score;
    }

    Project[] private _projects;

    mapping (string => Project) private projects;

    string[] private projectIds;

    address[] private access_list;

    mapping (address => bool) private accesslist;

    event AddProject(address indexed ca, string name, string projectId);

    constructor(
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
        address _owner
    ) {
        name = _name;

        description = _description;

        dev = _dev;

        email = _email;

        age = _age;

        phone_number = phone;

        country = _country;

        state = _state;

        residential_address = _address;

        profile_pic_url = url;

        reputation_score = 0;

        owner = _owner;

        super_owner = msg.sender;

        access_list.push(owner);

        access_list.push(super_owner);

        accesslist[owner] = true;

        accesslist[super_owner] = true;
    }

    modifier onlyOwner {
        require(msg.sender == owner || msg.sender == super_owner, "Not Authorized.");
        _;
    }

    modifier onlySuperOwner {
        require(msg.sender == super_owner, "Not Authorized.");
        _;
    }

    function getOwner() public view returns (address) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return owner;
    }

    function getName() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return name;
    }

    function getDescription() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return description;
    }

    function isDev() public view returns (bool) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return dev;
    }

    function getEmail() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return email;
    }

    function getAge() public view returns (uint256) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return age;
    }

    function getPhoneNumber() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return phone_number;
    }

    function getCountry() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return country;
    }

    function getState() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return state;
    }

    function getResidentialAddress() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return residential_address;
    }

    function getProfilePicUrl() public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return profile_pic_url;
    }

    function getReputationScore() public view returns (uint256) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return reputation_score;
    }

    function getProjectIds() public view returns (string[] memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return projectIds;
    }

    function getAccessList() public view returns (address[] memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return access_list;
    }

    function getAccountAccess(address account) public view returns (bool) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return accesslist[account];
    }

    function getProjects() public view returns (Project[] memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");

        return _projects;
    }

    function addProject(
        string memory _name,
        string memory _description,
        address _contract_address,
        string memory _website_link,
        string memory _telegram_link,
        string memory _twitter_link,
        string memory _discord_link,
        string memory _linktree
    ) public onlyOwner {
        require(verified, "Not verified.");
        Project memory project = Project({
            name : _name,
            description : _description,
            contract_address : _contract_address,
            website_link : _website_link,
            telegram_link : _telegram_link,
            twitter_link : _twitter_link,
            discord_link : _discord_link,
            linktree : _linktree,
            isHoneyPot : false,
            isRugged : false,
            reputation_score : 100
        });

        string memory projectId = string(abi.encodePacked("IDBot-", owner, "#", block.timestamp));

        _projects.push(project);

        projects[projectId] = project;
        
        reputation_score += 100;

        emit AddProject(_contract_address, _name, projectId);
    }

    function getProjectName(string memory id) public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        return project.name;
    }

    function getProjectDescription(string memory id) public view returns (string memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        return project.description;
    }

    function getProjectContractAddress(string memory id) public view returns (address) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        return project.contract_address;
    }

    function getProjectLinks(string memory id) public view returns (string[5] memory) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        string[5] memory links = [
            project.website_link,
            project.telegram_link,
            project.twitter_link,
            project.discord_link,
            project.linktree
        ];

        return links;
    }

    function checkIfProjectIsHoneyPot(string memory id) public view returns (bool) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        return project.isHoneyPot;
    }

    function checkIfProjectIsRugged(string memory id) public view returns (bool) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        return project.isRugged;
    }

    function getProjectReputationScore(string memory id) public view returns (uint256) {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project memory project = projects[id];

        return project.reputation_score;
    }

    function reportProjectIsHoneyPot(string memory id) public {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project storage project = projects[id];

        if(project.isHoneyPot == false) {
            project.isHoneyPot = true;
        }

        project.reputation_score -= 1;

        reputation_score -= 1;
    }

    function reportProjectIsRugged(string memory id) public {
        require(accesslist[msg.sender], "You are not authorized to perform this transaction.");
        Project storage project = projects[id];

        if(project.isRugged == false) {
            project.isRugged = true;
        }

        project.reputation_score -= 1;

        reputation_score -= 1;
    }

    function changeOwner(address _owner) public onlyOwner {
        require(verified, "Not verified.");
        owner = _owner;
    }

    function addAccountToAccessList(address account) public onlySuperOwner {
        access_list.push(account);

        accesslist[account] = true;
    }

    function removeAccountFromAccessList(address account) public onlySuperOwner {
        accesslist[account] = false;
    }

    function addVerification() public onlySuperOwner {
        verified = true;
    }

    function removeVerification() public onlySuperOwner {
        verified = false;
    }
}