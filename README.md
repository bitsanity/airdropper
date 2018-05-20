# airdropper

This is an owned smart contract intended to hold any number of tokens.

The owner may call an `airdrop( address tokensca, address[] recipients, uint256[] quantities )` function that simply confirms the array lengths match. Then it goes through each `address <--> uint` parameter tuple and confirms the quanity is non-zero. If so then it invokes the `tokensca.transfer(addr to, uint256 qty)` function. We expect the transfer to throw if anything is amiss otherwise we assume it was fine.

The advantage is that batching transactions this way saves the 21000 gas base fee we have to pay for each blockchain transaction. So if we batch N transactions we save (N-1) * 21000 gas. The only limitation is the ethereum network block gas limit currently 8 MBytes.

Another advantage is that the airdropper sca becomes the msg.sender and the apparent source of the transfer. In this way somewhat a proxy. Though any user very familiar with blockchain tools  will be able to follow the transactions through the airdropper and determine the source of the tokens and eoa of the owner.
