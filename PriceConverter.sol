// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

// No state variables and all the functions are internal, unless the library is to be deployed.
library PriceConverter {

    address constant ETH_IN_USD_CHAINLINK_CONTRACT = 0x694AA1769357215DE4FAC081bf1f309aDC325306;

    function getPrice() internal view returns (uint256) {
        // Extracting real-world pricing information using the Aggregator V3 interface from Chainlink    
        AggregatorV3Interface priceFeed = AggregatorV3Interface(ETH_IN_USD_CHAINLINK_CONTRACT);
        ( , int256 price, , ,) = priceFeed.latestRoundData();  // Five values are returned by this function
        // 8 to 18 decimals conversion
        return uint256(price * 1e10);
    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        // Always multiply before you divide
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() internal view returns (uint256) {
        return AggregatorV3Interface(ETH_IN_USD_CHAINLINK_CONTRACT).version();
    } 
}
