// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

import {SimpleStorage} from "./SimpleStorage.sol";

contract AddFiveStorage is SimpleStorage {
    function sayHello() public pure returns(string memory) {
        return "Hello";
    }

    function store(uint256 _myNumber) public override {
        myFavoriteNumber = _myNumber + 5;
    }
}
