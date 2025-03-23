// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;
import "lib/aave-v3-core/contracts/interfaces/IPool.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol"; // Interface ERC20

contract SimpleAaveDeposit {
    IPool public immutable aavePool;
    IERC20 public immutable DAI;

    constructor(address _aavePool, address _DAI) {
        aavePool = IPool(_aavePool);
        DAI = IERC20(_DAI);
    }


    /// @notice Déposer du DAI dans AAVE
    function depositDAI(uint256 amount) external {
        require(amount > 0, "Must deposit more than 0");

        // Approve AAVE Pool à utiliser nos DAI
        DAI.approve(address(aavePool), amount);
        console.log("Approval envoyee");

        // Déposer DAI dans AAVE
        aavePool.supply(address(DAI), amount, msg.sender, 0);
        console.log("Depot fait dans Aave");


        console.log("Balance apres depot:", DAI.balanceOf(address(this)));

    }
}
//refaire tout les evaluators et le contrat avec les deux nouvelles adresses