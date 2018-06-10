// 0.4.21+commit.dfe3193c.Emscripten.clang
pragma solidity ^0.4.21;

// we assume ERC20 or compatible token with most basic imaginable transfer function
interface ERC20 {
  function transfer( address to, uint256 value ) external;
}

contract owned {
  address public owner;

  function owned() public {
    owner = msg.sender;
  }

  function changeOwner( address _miner ) public onlyOwner {
    owner = _miner;
  }

  modifier onlyOwner {
    require (msg.sender == owner);
    _;
  }
}

//
// NOTE: this Airdropper becomes msg.sender for the token transfer and must
//       already be the holder of enough tokens
//
// NOTE: caller responsible to check ethstats.net for block size limit
//
contract Airdropper is owned {

  // distribute according to a number of (address,quantity) tuples. Maximum control but max cost due
  // to the transaction size

  function airdrop( address tokAddr,
                    address[] dests,
                    uint[] quantities ) public onlyOwner returns (uint) {

    for (uint ii = 0; ii < dests.length; ii++) {
      ERC20(tokAddr).transfer( dests[ii], quantities[ii] );
    }

    return ii;
  }

  // save gas: all destinations will get the same number of token units

  function airdrop( address tokAddr,
                    address[] dests,
                    uint quant ) public onlyOwner returns (uint) {

    for (uint ii = 0; ii < dests.length; ii++) {
      ERC20(tokAddr).transfer( dests[ii], quant );
    }

    return ii;
  }

}

