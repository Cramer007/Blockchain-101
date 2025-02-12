// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./interfaces/IPool.sol"; // Interface du pool AAVE
import "./interfaces/IWETHGateway.sol";


contract MyAaveInteraction is Ownable {
    IPool public immutable aavePool;
    IERC20 public immutable aDAI;
    IERC20 public immutable USDC;
    IERC20 public immutable variableDebtUSDC;
    IERC20 public immutable DAI;
    IWETHGateway public immutable wethGateway;



    address public immutable evaluator;

    constructor(
    address _aavePool,
    address _DAI,
    address _aDAI,
    address _USDC,
    address _variableDebtUSDC,
    address _wethGateway,
    address _evaluator
) {
    aavePool = IPool(_aavePool);
    DAI = IERC20(_DAI);
    aDAI = IERC20(_aDAI);
    USDC = IERC20(_USDC);
    variableDebtUSDC = IERC20(_variableDebtUSDC);
    wethGateway = IWETHGateway(_wethGateway);
    evaluator = _evaluator;
}


    /// @notice Déposer des tokens dans AAVE
    function depositSomeTokens() external {
        uint256 amount = 10 * 10**18; // 10 DAI
        DAI.approve(address(aavePool), amount);
        aavePool.supply(address(DAI), amount, address(this), 0);
    }


    /// @notice Emprunter des tokens depuis AAVE
    function borrowSomeTokens() external {
        uint256 amount = 5 * 10**6; // 5 USDC (USDC a 6 décimales)
        aavePool.borrow(address(USDC), amount, 2, 0, address(this));
    }

    /// @notice Rembourser les tokens empruntés
    function repaySomeTokens() external {
        uint256 amount = 5 * 10**6; // 5 USDC
        USDC.approve(address(aavePool), amount);
        aavePool.repay(address(USDC), amount, 2, address(this));
    }

    /// @notice Retirer les tokens déposés
    function withdrawSomeTokens() external {
        uint256 amount = 10 * 10**18; // 10 DAI
        aavePool.withdraw(address(USDC), amount, address(this));
    }
}
