pragma solidity ^0.4.11;
import './iERC20.sol';

contract Batchtransfer {
    address public owner;
    address public vmeTokenAddress;

    function Batchtransfer(address tokenAddress) {
        owner = msg.sender;
        vmeTokenAddress = tokenAddress;
    }

    modifier onlyOwner() {
      if (msg.sender != owner) {
        throw;
      }
      _;
    }

    function transferOwnership(address newOwner) onlyOwner {
      if (newOwner != address(0)) {
        owner = newOwner;
      }
    }

    function multisend(address[] dests, uint256[] values) public
    onlyOwner
    returns (uint256) {
        uint256 i = 0;
        while (i < dests.length) {
           iERC20(vmeTokenAddress).transfer(dests[i], values[i]);
           i += 1;
        }
        return(i);
    }
}
