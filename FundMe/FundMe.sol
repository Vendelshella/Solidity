// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// Importar un contrato que está fuera de nuestro proyecto

import {PriceConsumerV3} from "./PriceConsumerV3.sol";
//@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {

    using PriceConverter for uint256;

    uint public minimumUSD = 5 * 1e18;

    address[] public funders;

    mapping (address funder=> uint256 amountFunded) public amountAddressFunded;

    address public owner;

    // El constructor es llamado inmediatamente al desplegar el contrato
    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        // getConversionRate() No necesita un parámetro uint porque msg.value tiene un valor uint256 y es el valor que le pasa a la función.
        require(msg.value.getConversionRate() >= minimumUSD, "Did not send enought ETH");
        funders.push(msg.sender);
        // Esto añade el valor enviado (msg.value) a la cantidad total ya donada por esa dirección y actualiza ese valor en el mapping.
        amountAddressFunded[msg.sender] = amountAddressFunded[msg.sender] + msg.value;
        // Lo anterior es igual a: amountAddressFunded[msg.sender] += msg.value;
    }
    
    function withdraw() public onlyOwner {
        
        // for loop para recorrer el array de funders
        for (uint funderIndex = 0; funderIndex < funders.length; funderIndex++) {
            address funder = funders[funderIndex];
            // Con la siguiente línea reseteamos la dirección del donante dentro del array funders
            // porque estamos retirando el dinero donado.
            amountAddressFunded[funder] = 0;
        }

        // Resetear el array funders en un nuevo array vacío:
        funders = new address[](0);

        // Ways of withdraw the funds:
        // transfer
        // send
        // call

        // msg.sender = address
        // payable(msg.sender) = payable address

        // TRANSFER
        // payable(msg.sender).transfer(address(this).balance); // this hace referencia al contrato
        // SEND
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");
        // CALL (podemos llamar a cualquier funcion sin un ABI)
        (bool callSuccess, /*bytes memory dataReturned*/) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Send failed");

    }
    
    modifier onlyOwner() {
        // Con la siguiente línea nos aseguramos que solo el propietario del contrato pueda retirar los fondos
        require(msg.sender == owner, "Must the owner");
        _; // Ejecuta el resto del código de la función. Puede ir por encima de la anterior línea.
    }
}