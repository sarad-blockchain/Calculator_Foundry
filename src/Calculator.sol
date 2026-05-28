//SPDX-License-Identifier: MIT

pragma solidity ^0.8.35;

// @title  Basic Calculator
// @author Sara Deleyto
// @notice Contract to perform arithmetic operations

contract Calculator {

    uint256 public result;
    address public admin;

    event Add(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
    event Subtract(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
    event Multiply(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);
    event Divide(uint256 firstNumber_, uint256 secondNumber_, uint256 result_);

    modifier onlyAdmin(){
        require(msg.sender == admin, "Only the admin can perform this action");
        _;
    }

    constructor(uint256 firstResult_, address admin_) {
        result = firstResult_;
        admin = admin_;
    }   

    // @notice Adds two numbers
    // @param  First number
    // @param  Second number
    // @return sum of First and Second numbers
    function add(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 result_){
        result_ = firstNumber_ + secondNumber_;
        result = result_;

        emit Add(firstNumber_, secondNumber_, result_);
    }

    // @notice Subtracts two numbers
    // @param  First number
    // @param  Second number
    // @return difference of First and Second numbers
    function subtract(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 result_){
        result_ = firstNumber_ - secondNumber_;
        result = result_;

        emit Subtract(firstNumber_, secondNumber_, result_);
    }

    // @notice Multiplies two numbers
    // @param  First number
    // @param  Second number
    // @return product of First and Second numbers
    function multiply(uint256 firstNumber_, uint256 secondNumber_) external returns(uint256 result_){
        result_ = firstNumber_ * secondNumber_;
        result = result_;

        emit Multiply(firstNumber_, secondNumber_, result_);
    }

    // @notice Divides two numbers
    // @param  First number (dividend)
    // @param  Second number (divisor)
    // @return quotient of First and Second numbers
    function divide(uint256 firstNumber_, uint256 secondNumber_) external onlyAdmin returns(uint256 result_){
        require(secondNumber_ != 0, "Division by zero is not allowed");
        result_ = firstNumber_ / secondNumber_;
        result = result_;

        emit Divide(firstNumber_, secondNumber_, result_);
    }
    
}
