//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.3;

import "./ERC20.sol";
import "hardhat/console.sol";

contract SimpleToken is ERC20 {

  string public constant name = "Mirror";
  string public constant symbol = "MIR";
  uint8 public constant decimals = 18;

  uint256 public constant INITIAL_SUPPLY = 10000 * (10 ** uint256(decimals));

  constructor() public {
    _mint(msg.sender, INITIAL_SUPPLY);
  }
}