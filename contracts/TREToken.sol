//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract TREToken is ERC20 {
  address payable private host;
  uint256 private commissionPercentage;

  constructor(uint256 initialSupply) ERC20("Tree", "TRE") {
    host = payable(address(0x003c44cdddb6a900fa2b585dd299e03d12fa4293bc));
    commissionPercentage = 10;

    _mint(msg.sender, initialSupply);
  }

  function decimals() public pure override returns (uint8) {
    return 0;
  }

  receive() external payable {
    swapWEIToTRE(msg.value);
  }

  function swapWEIToTRE(uint256 weiToSwap) private returns (bool) {
    require(weiToSwap <= _msgSender().balance, "Not enough balance to swap");

    (bool sent, ) = host.call{ value: weiToSwap }("");
    require(sent, "Failed to send ethereum");

    uint256 treToSwap = weiToSwap / 1e14; // about 400 krw
    _mint(msg.sender, treToSwap);

    return true;
  }

  function transfer(address to, uint256 amount)
    public
    virtual
    override
    returns (bool)
  {
    address owner = _msgSender();
    uint256 commission = (amount * commissionPercentage) / 100;
    uint256 realAmount = (amount * (100 - commissionPercentage)) / 100;

    _transfer(owner, host, commission);
    _transfer(owner, to, realAmount);
    return true;
  }
}
