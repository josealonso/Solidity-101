// SPDX-License-Identifier: MIT
// pragma solidity 0.8.18;  // Error as of July 2026
pragma solidity 0.8.34;

contract SimpleStorage {
    // variable types: int, uint, boolean, address, bytes32
    // string is a bytes object.

    // bytes64 number;  // Error, bytes32 is the maximum
    // Everything in the EVM is public data
    uint256 myFavoriteNumber;  // 0  // internal is the default modifier for variables

    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    mapping(string => uint256) public nameToFavoriteNumber;  // The default value for all the keys is 0

    function store(uint256 _favoriteNumber) public virtual {
        myFavoriteNumber = _favoriteNumber;
    }

    // view, pure ---> When applied to functions, calling those functions
    // cost no gas 
    function retrieve() public view returns(uint256) {
        return myFavoriteNumber;
    }

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        // listOfPersons.push( Person(_favoriteNumber, _name));
        nameToFavoriteNumber[_name] = _favoriteNumber;
    }

    // calldata, memory, storage
    // The first two imply temporary storage, but a "memory" variable can be modified.
    // Arrays (including strings), structs and mappings are special data types
}
