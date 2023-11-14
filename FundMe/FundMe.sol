// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// Importar un contrato que está fuera de nuestro proyecto

import {PriceConsumerV3} from "./PriceConsumerV3.sol";
//@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol
import {AggregatorV3Interface} from "./AggregatorV3Interface.sol";

contract FundMe {

    uint public minimumUSD = 5 * 1e18;

    address[] public funders;

    mapping (address funder=> uint256 amountFunded) public amountAddressFunded;

    function fund() public payable {
        require(getConvertionRate(msg.value) >= minimumUSD, "Did not send enought ETH");
        funders.push(msg.sender);
        // Esto añade el valor enviado (msg.value) a la cantidad total ya donada por esa dirección y actualiza ese valor en el mapping.
        amountAddressFunded[msg.sender] = amountAddressFunded[msg.sender] + msg.value;
    }
    /*
    function withdraw(params) public {
        code
    }
    */

    function getPrice() public view returns (uint) {
        // Cuando interectuamos con un contrato necesitamos el address y el ABI
        // https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1&search=
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI: 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price, , ,) = priceFeed.latestRoundData(); // Los demás valores son ignorados
        return uint256 (price * 1e10);
    }
    
    function getVersion() public view returns (uint) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    // Funcion para convertir los ETH en USD
    function getConvertionRate(uint ethAmount) public view returns (uint) {
        uint ethPrice = getPrice();
        uint ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
    
}