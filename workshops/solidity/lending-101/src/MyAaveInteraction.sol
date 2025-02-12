// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@aave-v3-core/contracts/interfaces/IPool.sol";


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

        // Déposer DAI dans AAVE
        aavePool.supply(address(DAI), amount, msg.sender, 0);
    }
}
