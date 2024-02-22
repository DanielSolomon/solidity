// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract SimpleStorage {
    uint public storedData;

    constructor(uint value) {
        storedData = value;
    }

    function set(uint value) public {
        storedData = value;
    }
}
