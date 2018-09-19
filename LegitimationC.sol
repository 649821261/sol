pragma solidity ^0.4.24;

import "./LegitimationB.sol"

contract LegitimationC is LegitimationB {
    /* This creates an array with all legal info */
    mapping (address => string) public fileNames;
    mapping (address => string) public hashCodes;
    mapping (address => uint)   public timeStamps;
    mapping (address => bool)   public signed;
    
    modifier notSigned() {
        require(!signed[msg.sender]);
        _;
    }

    /* This generates a public event on the blockchain that will notify clients */
    event Sign(address indexed signee, string fileName, string hashCode, uint256 timeStamp);
    
    function signAgreementWithCode(string fileName, string hashCode, string code) public notSigned {
        require(bytes(fileName).length > 0);
        require(bytes(hashCode).length > 0);
        
        fileNames[msg.sender] = code;
        hashCodes[msg.sender] = hashCode;
        timeStamps[msg.sender] = now;
        signed[msg.sender] = true;
        
        emit Sign(msg.sender, fileName, hashCode, now);
    }
}
