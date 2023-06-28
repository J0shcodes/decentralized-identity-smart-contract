// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract IdentityManagement {
    address public owner;
    mapping(address => bool) public admins;
    
    struct Identity {
        address identityOwner;
        string name;
        uint256 age;
        string email;
    }
    
    mapping(address => Identity) public identities;
    
    event IdentityCreated(address indexed _identityOwner, string name);
    event IdentityUpdated(address indexed _identityOwner, string name);
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only contract owner can perform this action");
        _;
    }
    
    modifier onlyAdmin() {
        require(admins[msg.sender], "Only administrators can perform this action");
        _;
    }
    
    constructor() {
        owner = msg.sender;
        admins[msg.sender] = true;
    }
    
    function addAdmin(address _admin) public onlyOwner {
        admins[_admin] = true;
    }
    
    function removeAdmin(address _admin) public onlyOwner {
        require(_admin != owner, "Contract owner cannot be removed as admin");
        admins[_admin] = false;
    }
    
    function createIdentity(string memory _name, uint256 _age, string memory _email) public {
        require(identities[msg.sender].identityOwner == address(0), "Identity already exists");
        
        Identity storage newIdentity = identities[msg.sender];
        newIdentity.identityOwner = msg.sender;
        newIdentity.name = _name;
        newIdentity.age = _age;
        newIdentity.email = _email;
        
        emit IdentityCreated(msg.sender, _name);
    }
    
    function updateIdentity(string memory _name, uint256 _age, string memory _email) public onlyAdmin {
        require(identities[msg.sender].identityOwner != address(0), "Identity does not exist");
        
        Identity storage updatedIdentity = identities[msg.sender];
        updatedIdentity.name = _name;
        updatedIdentity.age = _age;
        updatedIdentity.email = _email;
        
        emit IdentityUpdated(msg.sender, _name);
    }
    
    function getIdentity(address _owner) public view returns (string memory, uint256, string memory) {
        Identity storage identity = identities[_owner];
        return (identity.name, identity.age, identity.email);
    }
}