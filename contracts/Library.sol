//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;


contract smartLibrary
{
    /*
    *@notice Instance of Library Item
    */
    struct content
    {
        string name;
        string Link;
        string description;
    }

    /*
    *@notice Id counter 
    */
    uint256 public count = 0;

    /*
    *@notice maps user to their library
    */
    mapping (address=>mapping(uint256=>content)) userLib;
    mapping (address=>content[])privlib;

    /**
    @notice Events to log public library
    */
    event PublicUpload(string indexed _name, string _Link, string _description);
    

    /*
    *@notice array of public library items
    */
    content[] private publicLib;

    /*
    *@notice uploads privately to users library
    */
    function PrivateUpload(string memory _name, string memory _Link, string memory _description) public returns(string memory)
    {
        count++;
        userLib[msg.sender][count]=content(_name, _Link, _description);
        privlib[msg.sender].push(content(_name, _Link,_description));
        return ("Added to Private Library");
    }

    /*
    *@notice Uploads publicly into array publicLib
    */
    function publicUpload(string memory _name, string memory _Link, string memory _description) public returns(string memory)
    {
        content memory Content = content(_name, _Link, _description);
        publicLib.push(Content);
        emit PublicUpload(_name, _Link, _description);
         return ("Added to Public Library");
    }


    /*
    *@notice shares item in library
    */
    function share(address[] memory _to, uint256 _ID) public returns(string memory)
    {
        content memory c = userLib[msg.sender][_ID];
        
        for(uint256 i=0; i<_to.length; i++) {
        require(_to[i] != address(0),"you cant share to zero address");
        
        userLib[_to[i]][_ID] = content(c.name, c.Link, c.description);
        }
        return "shared";

    }


    /*
    *@notice view Library items
    */
    function viewPrivateLib() public view returns(content[] memory )
    {
        return privlib[msg.sender];
    // for(uint i=0; i<privlib[msg.sender].length; i++ )
    // {
         
        // p.push( privlib[msg.sender][i]);
        
   //  }
    }
}
