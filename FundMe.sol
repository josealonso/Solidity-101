// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// A revert undoes any action, and send the remaining gas back.
contract FundMe {
    address constant ETH_IN_USD_CHAINLINK_CONTRACT = 0x694AA1769357215DE4FAC081bf1f309aDC325306;
    uint256 public minimumUSD = 5;
    uint256 public myVar = 1;
    // The tx reverts if less than 1 Ether is sent.
    function fund() public payable {
        myVar = myVar + 1;
        require(msg.value > 1e18, "didn't send enough Eth");  // 1e18 = 1 Eth = 1 * 10 ** 18 Wei
        // myVar equals 1 id the tx is reverted.
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

    function getPrice() public view returns (uint256) {
        // Extracting real-world pricing information using the Aggregator V3 interface from Chainlink    
        AggregatorV3Interface priceFeed = AggregatorV3Interface(ETH_IN_USD_CHAINLINK_CONTRACT);
        ( , int256 price, , ,) = priceFeed.latestRoundData();  // Five values are returned by this function
        // 8 to 18 decimals conversion
        return uint256(price * 1e10);
    }

    function withdraw() public {

    }

}

// Blockchains are deterministic systems

