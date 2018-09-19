pragma solidity ^0.4.24;

contract LegitimationB {
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
    
    function signAgreement(string fileName, string hashCode) public notSigned {
        require(bytes(fileName).length > 0);
        require(bytes(hashCode).length > 0);
        
        fileNames[msg.sender] = fileName;
        hashCodes[msg.sender] = hashCode;
        timeStamps[msg.sender] = now;
        signed[msg.sender] = true;
        
        emit Sign(msg.sender, fileName, hashCode, now);
    }

    function signAgreementWithFlag(string fileName, string hashCode, string flag) public notSigned {
        require(bytes(fileName).length > 0);
        require(bytes(hashCode).length > 0);
        
        fileNames[msg.sender] = fileName;
        hashCodes[msg.sender] = flag;
        timeStamps[msg.sender] = now;
        signed[msg.sender] = true;
        
        emit Sign(msg.sender, fileName, hashCode, now);
    }
}
