// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "./AggregatorV3Interface.sol";

// La visibilidad internal significa que la función solo es accesible internamente dentro del contrato y por contratos herederos.
// Por ejemplo, si tienes una función que realiza ciertos cálculos o actualizaciones de estado específicos para el contrato, pero no quieres que sea accesible públicamente o desde contratos externos, puedes declararla como internal.

library PriceConverter {
    
    function getPrice() internal view returns (uint) {
        // Cuando interectuamos con un contrato necesitamos el address y el ABI
        // https://docs.chain.link/data-feeds/price-feeds/addresses?network=ethereum&page=1&search=
        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI: 
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (, int price, , ,) = priceFeed.latestRoundData(); // Los demás valores son ignorados
        return uint256 (price * 1e10);
    }
    
    function getVersion() internal  view returns (uint) {
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    }

    // Funcion para convertir los ETH en USD
    function getConversionRate(uint ethAmount) internal view returns (uint) {
        uint ethPrice = getPrice();
        uint ethAmountInUSD = (ethPrice * ethAmount) / 1e18;
        return ethAmountInUSD;
    }
    
}