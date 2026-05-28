# Calculator — Foundry Project

A simple on-chain calculator written in Solidity as a first hands-on project with the [Foundry](https://book.getfoundry.sh/) development toolkit.

The contract exposes four arithmetic operations and introduces key Solidity concepts: state variables, events, access control with a modifier, and division-by-zero protection.

---

## Contract Overview

**`src/Calculator.sol`**

| Feature | Details |
|---|---|
| Language | Solidity `^0.8.35` |
| State | `result` (last computed value), `admin` (privileged address) |
| Access control | `onlyAdmin` modifier — only the admin can call `divide` |
| Events | `Add`, `Subtract`, `Multiply`, `Divide` emitted on every operation |

### Functions

| Function | Visibility | Access | Description |
|---|---|---|---|
| `add(a, b)` | external | anyone | Returns `a + b` and stores it in `result` |
| `subtract(a, b)` | external | anyone | Returns `a - b` and stores it in `result` |
| `multiply(a, b)` | external | anyone | Returns `a * b` and stores it in `result` |
| `divide(a, b)` | external | **admin only** | Returns `a / b`; reverts if `b == 0` |

### Constructor

```solidity
constructor(uint256 firstResult_, address admin_)
```

Sets the initial value of `result` and assigns the `admin` address on deployment.

---

## Project Structure

```
.
├── src/
│   └── Calculator.sol       # Main contract
├── test/
│   └── Calculator.t.sol     # Unit and fuzz tests
├── script/
│   └── Calculator.s.sol     # Deployment script (WIP)
├── lib/
│   └── forge-std/           # Foundry standard library (submodule)
└── foundry.toml             # Foundry configuration
```

---

## Tests

The test suite in `test/Calculator.t.sol` covers:

**Unit tests (fixed inputs)**

- `testCheckFirstResult` — verifies the constructor sets `result` correctly
- `testAdd` — basic addition check
- `testSubtract` — basic subtraction check
- `testMultiply` — basic multiplication check
- `testCanNotMultiply2NumbersTooBig` — overflow reverts as expected
- `testIfNotAdminCallDivideReverts` — non-admin cannot call `divide`
- `testAdminCanCallDivide` — admin can call `divide` successfully
- `testDefaultCanNotAdminCanCallDivide` — default caller (not admin) is rejected
- `testDefaultExecuteCorrectlyDivide` — admin gets the correct quotient
- `testDivideByZeroReverts` — dividing by zero reverts with the expected message

**Fuzz tests (random inputs)**

- `testFuzzDivide` — runs `divide` with random inputs via the admin to surface unexpected reverts

> Fuzz runs are configured to `350` iterations in `foundry.toml`. Increase `run` for more thorough fuzzing.

---

## Getting Started

### Prerequisites

Install Foundry:

```bash
curl -L https://foundry.paradigm.xyz | bash
foundryup
```

### Install dependencies

```bash
forge install
```

### Build

```bash
forge build
```

### Run tests

```bash
forge test
```

Run with verbose output to see individual test results:

```bash
forge test -vv
```

### Format

```bash
forge fmt
```

---

## Author

Sara Deleyto