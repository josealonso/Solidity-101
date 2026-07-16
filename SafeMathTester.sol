// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract SafeMathTester {
    // unchecked in Solidity versions prior to 0.8
    uint8 public bigNumer = 255;    

    function add() public {
        bigNumer = bigNumer + 1;
    }
}

/*
Above code is equivalent to this modern Solidity code

    function add() public {
        unchecked{bigNumer = bigNumer + 1;}
    }
*/

