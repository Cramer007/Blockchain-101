// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./interfaces/IPool.sol";
import "./ERC20TD.sol";

import {IPool} from "./interfaces/IPool.sol";
import {IFlashLoanSimpleReceiver} from "./interfaces/IFlashLoanSimpleReceiver.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";


import {AAVE_POOL_ADDRESS, DAI_ADDRESS, USDC_ADDRESS, ADAI_ADDRESS} from "./Constants.sol";

contract ExerciseSolution {
    function depositSomeTokens() external {
        ERC20TD dai = ERC20TD(DAI_ADDRESS);
        uint256 amount = 10 * 10 ** 18;
        
        dai.approve(AAVE_POOL_ADDRESS, amount);
        IPool(AAVE_POOL_ADDRESS).supply(DAI_ADDRESS, amount, address(this), 0);
    }
    function borrowSomeTokens() external {
        IPool aavePool = IPool(AAVE_POOL_ADDRESS);
        // Emprunt de 1 USDC (6 décimales) avec taux variable
        
        aavePool.borrow(USDC_ADDRESS, 1 * 10 ** 6, 2, 0, address(this));
    }
    function repaySomeTokens() external {
        ERC20TD usdc = ERC20TD(USDC_ADDRESS);
        ERC20TD variableDebtUSDC = ERC20TD(USDC_ADDRESS);
        uint256 debt = variableDebtUSDC.balanceOf(address(this));
        
        usdc.approve(AAVE_POOL_ADDRESS, debt);
        IPool(AAVE_POOL_ADDRESS).repay(USDC_ADDRESS, debt, 2, address(this));
    }


    function withdrawSomeTokens() external {
    ERC20TD aDai = ERC20TD(ADAI_ADDRESS);
    uint256 amount = aDai.balanceOf(address(this));

    uint256 withdrawnAmount = IPool(AAVE_POOL_ADDRESS).withdraw(DAI_ADDRESS, amount, address(this));
    require(withdrawnAmount > 0, "Withdrawal failed");
    }

}

