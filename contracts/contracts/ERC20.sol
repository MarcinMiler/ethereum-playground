//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.3;

import "hardhat/console.sol";

contract ERC20 {
  event Tranfer(
    address indexed from,
    address indexed to,
    uint256 value
  );

  event Approval(
    address indexed owner,
    address indexed spender,
    uint256 value
  );

  mapping (address => uint256) private _balances;

  mapping (address => mapping (address => uint256)) private _allowed;

  uint256 private _totalSupply;

  function totalSupply() public view returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address owner) public view returns (uint256) {
    return _balances[owner];
  }

  function allowance(address owner, address sender) public view returns (uint256) {
    return _allowed[owner][sender];
  }

  function transfer(address to, uint256 value) public returns (bool) {
    require(_balances[msg.sender] >= value);
    require(to != address(0));

    _balances[msg.sender] -= value;
    _balances[to] += value;

    emit Tranfer(msg.sender, to, value);
    return true;
  }

  function approve(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));

    _allowed[msg.sender][spender] = value;

    emit Approval(msg.sender, spender, value);
    return true;
  }

  function transferFrom(address from, address to, uint256 value) public returns (bool) {
    require(_balances[from] >= value);
    require(_allowed[from][msg.sender] >= value);
    require(to != address(0));

    _balances[from] -= value;
    _balances[to] += value;
    _allowed[from][msg.sender] -= value;
    
    emit Tranfer(from, to, value);
    return true;
  }

  function increaseAllowance(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));

    _allowed[msg.sender][spender] += value;

    emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
    return true;
  }

  function decreaseAllowance(address spender, uint256 value) public returns (bool) {
    require(spender != address(0));

    _allowed[msg.sender][spender] -= value;

    emit Approval(msg.sender, spender, _allowed[msg.sender][spender]);
    return true;
  }

  function _mint(address account, uint256 amount) internal {
    require(account != address(0));

    _totalSupply += amount;
    _balances[account] += amount;

    emit Tranfer(address(0), account, amount);
  }

  function _burn(address account, uint256 amount) internal {
    require(account != address(0));
    require(_balances[account] >= amount);

    _totalSupply -= amount;
    _balances[account] -= amount;

    emit Tranfer(account, address(0), amount);
  }

  function _burnFrom(address account, uint256 amount) internal {
    require(_allowed[account][msg.sender] >= amount);

    _allowed[account][msg.sender] -= amount;

    _burn(account, amount);
  }
}