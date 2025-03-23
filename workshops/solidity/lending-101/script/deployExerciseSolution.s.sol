// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import "../src/ExerciseSolution.sol";

contract DeployExerciseSolution is Script {
    function run() public {
        vm.startBroadcast();

        // Déployer le contrat étudiant
        ExerciseSolution studentContract = new ExerciseSolution();

        vm.stopBroadcast();

        console.log("ExerciseSolution deployed at:", address(studentContract));
    }
}
