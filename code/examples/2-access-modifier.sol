// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0;

contract PrivateSimpleStorage {
    uint private storedData;

    constructor(uint value) {
        storedData = value;
    }

    function set(uint value) public {
        storedData = value;
    }
}

contract PrivateWithViewSimpleStorage {
    uint private storedData;

    constructor(uint value) {
        storedData = value;
    }

    function set(uint value) public {
        storedData = value;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}
