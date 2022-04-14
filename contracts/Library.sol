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

    /*
    @notice Events to log public library
    */
    event PublicUpload(string indexed _name, string _description, string _Link);

    /*
    *@notice array of public library items
    */
    content[]private publicLib;

    /*
    *@notice uploads privately to users library
    */
    function privateUpload(string memory _name, string memory _description, string memory _Link)public returns(string memory)
    {
        count++;
        userLib[msg.sender][count]=content(_name,_description,_Link);
        return ("Added to Private Library");
    }

    /*
    *@notice Uploads publicly into array publicLib
    */
    function publicUpload(string memory _name, string memory _description, string memory _Link)public returns(string memory)
    {
        content memory Content = content(_name,_description,_Link);
        publicLib.push(Content);
        emit PublicUpload(_name, _description, _Link);
         return ("Added to Public Library");
    }


    /*
    *@notice shares item in library
    */
    function share(address _to,uint256 _ID)public returns(string memory)
    {
        content memory c = userLib[msg.sender][_ID];
        //userLib[_to][_ID] = userLib[msg.sender][_ID] ;
        userLib[_to][_ID] = content(c.name, c.Link, c.description);
        return "shared";

    }


    /*
    *@notice view Library item
    */
    function viewLib(uint256 _ID)public view returns(content memory)
    {
    return userLib[msg.sender][_ID];
    }
}