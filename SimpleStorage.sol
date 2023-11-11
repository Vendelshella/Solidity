// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.2 <0.9.0;

contract SimpleStorage {

    uint256 number;

    // Keyword virtual to override the function
    function store(uint256 num) public virtual {
        number = num;
    }

    function retrieve() public view returns (uint256){
        return number;
    }
}