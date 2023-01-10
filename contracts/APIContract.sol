// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/ChainlinkClient.sol";

contract APIConsumer is ChainlinkClient {
  using Chainlink for Chainlink.Request;

  uint256 public volume;
  bytes32 private jobId = "ca98366cc7314957b8c012c72f05aeeb";
  uint256 private fee = (1 * LINK_DIVISIBILITY) / 10;

  constructor() {
    setChainlinkToken(0x326C977E6efc84E512bB9C30f76E30c160eD06FB);
    setChainlinkOracle(0xCC79157eb46F5624204f47AB42b3906cAA40eaB7);
  }

  function requestVolumeData() public returns (bytes32 requestId) {
    Chainlink.Request memory req = buildChainlinkRequest(
      jobId,
      address(this),
      this.fulfill.selector
    );

    // Task 1 - httpget
    req.add("get","https://min-api.cryptocompare.com/data/pricemultifull?fsyms=ETH&tsyms=USD");
     
    // Task 2 - jsonparse
    req.add("path", "RAW,ETH,USD,VOLUME24HOUR");
     
    // Task 3 - multiply
    int256 timesAmount = 10 ** 18;
    req.addInt("times", timesAmount);

    return sendChainlinkRequest(req, fee);
  }

  function fulfill(bytes32 _requestId, uint256 _volume) 
    public recordChainlinkFulfillment(_requestId) {
        volume = _volume;
    } 

}
