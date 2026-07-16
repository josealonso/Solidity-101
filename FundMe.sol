// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    
    using PriceConverter for uint256;  // This allows to use "extension functions"

    uint256 public constant MINIMUM_USD = 50 * 1e18;
    address[] funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded; 

    address public immutable owner;

    constructor() {
        owner = msg.sender;  // The deployer is the owner
    }

    function fund() public payable {
        // The next two lines are equivalent
        require(PriceConverter.getConversionRate(msg.value) >= MINIMUM_USD, "didn't send enough Eth");  // 1e18 = 1 Eth = 1 * 10 ** 18 Wei
        require(msg.value.getConversionRate() >= MINIMUM_USD, "didn't send enough Eth");  // 1e18 = 1 Eth = 1 * 10 ** 18 Wei
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
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

   
    function withdraw() public onlyOwner {
        for (uint256 fundersIndex = 0; fundersIndex < funders.length; fundersIndex++) {
            address funder = funders[fundersIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Reset an array
        funders = new address[](0);  // Second meaning of the "new" keyword
        // withdraw the funds ---> Three ways: transfer, send and call.
        // 1.- transfer
        // throws an exception if not sent
        payable(msg.sender).transfer(address(this).balance); // transfer is deprecated
        // 2.- send
        bool successfullySent = payable(msg.sender).send(address(this).balance); // send is deprecated
        require(successfullySent, "Send failed");
        // 3.- call (recommended)
        (bool callSuccess, ) = payable(msg.sender).call{value: 2}("");  
        require(callSuccess, "Call failed");
    }

    modifier onlyOwner {
        // require(msg.sender == owner, "Must be owner!");
        // Custom errors are pretty new in Solidity
        if(msg.sender != owner) { revert NotOwner(); }
        _;
    }

    /*
    receive and fallback are special functions triggered when users send Ether directly to the contract or call non-existent functions. 
    These functions do not return anything and must be declared external.
    - When Ether is sent to the contract, the receive function is triggered. 
    - If a transaction includes data but the specified function does not exist, the fallback function will be triggered
    */
    receive() external payable { 
        fund();
    }

    fallback() external payable {
        fund();
    }
}

// Blockchains are deterministic systems

