// SPDX-License-Identifier: MIT

pragma solidity >=0.8.2 <0.9.0;

contract HelloWorld {
    string private helloMessage = "Hello world";

    function getHelloMessage () public view returns (string memory) {
        return helloMessage;
    }
}