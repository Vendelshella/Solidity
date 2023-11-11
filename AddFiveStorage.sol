// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {SimpleStorage} from "./SimpleStorage.sol";

// Este contrato será un hijo de SimpleStorage contract
// Heredará lo que contiene su padre
contract AddFiveStorage is SimpleStorage {
    /*
    function sayHello() public pure returns (string memory) {
        return "Hello";
    }
    */

    // Vamos a sobreescribir la funcion store (keywords: override & virtual)
    function store (uint _number) public override {
        number = _number + 5;
    }
}