// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    
    using PriceConverter for uint256;  // This allows to use "extension functions"

    uint256 public minimumUSD = 5e18;
    address[] funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; 

    function fund() public payable {
        // The next two lines are equivalent
        require(PriceConverter.getConversionRate(msg.value) >= minimumUSD, "didn't send enough Eth");  // 1e18 = 1 Eth = 1 * 10 ** 18 Wei
        require(msg.value.getConversionRate() >= minimumUSD, "didn't send enough Eth");  // 1e18 = 1 Eth = 1 * 10 ** 18 Wei
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }
   
    /* Transactions - Fields
    - Nonce: tx count for the account
    - Gas price: price per unit of gas (in wei)
    - Gas Limit (21000)
    - To: address that the tx is sent to
    - value: amount of wei to send 
    - Data: empty
    - v, r, s: components of tx signature
    */

   
    function withdraw() public {

    }

}

// Blockchains are deterministic systems

