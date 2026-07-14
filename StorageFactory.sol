// SPDX-License-Identifier: MIT

pragma solidity 0.8.34;
import {SimpleStorage} from "SimpleStorage.sol"; 

contract StorageFactory {
    SimpleStorage[] public listOfSimpleStorageContracts;

    function createSimpleStorageContract() public {
        // The "new" keyword creates a contract
        listOfSimpleStorageContracts.push(new SimpleStorage());
    }    

    function sfStore(uint256 _simpleStorageIndex, uint256 _newSimpleStorageNumber) public {
        // Address and ABI (Application Binary Interface)
        SimpleStorage mySimpleStorage = listOfSimpleStorageContracts[_simpleStorageIndex];
        mySimpleStorage.store(_newSimpleStorageNumber);
    }

    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return listOfSimpleStorageContracts[_simpleStorageIndex].retrieve();
    }
}
