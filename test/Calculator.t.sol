//SPDX-License-Identifier: MIT

pragma solidity ^0.8.35;

import "../src/calculator.sol";
import "../lib/forge-std/src/Test.sol";

contract CalculatorTest is Test{

    Calculator calculator;
    uint256 public firstResult = 100;
    address public admin = vm.addr(1); // vm.addr(1) creates a deterministic address for testing purposes
    address public nonAdmin = vm.addr(2);
    function setUp() public {
        calculator = new Calculator(firstResult, admin);
    }

    // Unit Testing - Given inputs

    function testCheckFirstResult() public view {
       uint256 firstResult_ = calculator.result();
       assert(firstResult_ == firstResult);
    }

    function testAdd() public {
        uint256 firstNumber = 10;
        uint256 secondNumber = 20;
    
        uint256 result_ = calculator.add(firstNumber, secondNumber);
        assert(result_ == firstNumber + secondNumber);
    }

    function testSubtract() public {
        uint256 firstNumber = 30;
        uint256 secondNumber = 15;
    
        uint256 result_ = calculator.subtract(firstNumber, secondNumber);
        assert(result_ == firstNumber - secondNumber);
    }

    function testMultiply() public {
        uint256 firstNumber = 5;
        uint256 secondNumber = 4;

        uint256 result_ = calculator.multiply(firstNumber, secondNumber);
        assert(result_ == firstNumber * secondNumber);
    }

    function testCanNotMultiply2NumbersTooBig() public {
        uint256 firstNumber = 2**256 - 2;
        uint256 secondNumber = 5;

        vm.expectRevert();
        calculator.multiply(firstNumber, secondNumber);
    }

    function testIfNotAdminCallDivideReverts() public {
        vm.startPrank(nonAdmin);

        uint256 firstNumber = 10;
        uint256 secondNumber = 5;

        vm.expectRevert();
        calculator.divide(firstNumber, secondNumber);

        vm.stopPrank();
    }

    function testAdminCanCallDivide() public {
        vm.startPrank(admin);

        uint256 firstNumber = 10;
        uint256 secondNumber = 5;
        calculator.divide(firstNumber, secondNumber);

        vm.stopPrank();
    }

     function testDefaultCanNotAdminCanCallDivide() public {
        uint256 firstNumber = 10;
        uint256 secondNumber = 5;
        vm.expectRevert();
        calculator.divide(firstNumber, secondNumber);
    }

    function testDefaultExecuteCorrectlyDivide() public {
        uint256 firstNumber = 10;
        uint256 secondNumber = 5;
        vm.prank(admin);
        uint256 result_ = calculator.divide(firstNumber, secondNumber);
        assert(result_ == firstNumber / secondNumber);
        vm.stopPrank();
    }

    function testDivideByZeroReverts() public {
        vm.prank(admin);
        uint256 firstNumber = 10;
        uint256 secondNumber = 0;

        vm.expectRevert("Division by zero is not allowed");
        calculator.divide(firstNumber, secondNumber);
        vm.stopPrank();
    }
    // Fuzzing Testing - Random inputs

    function testFuzzDivide(uint256 firstNumber, uint256 secondNumber) public {
        
        vm.prank(admin);

        calculator.divide(firstNumber, secondNumber);
        vm.stopPrank();

    }

 }