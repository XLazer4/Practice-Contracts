// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;
import "@chainlink/contracts/src/v0.8/VRFV2WrapperConsumerBase.sol";

contract RandomNumberConsumer is VRFV2WrapperConsumerBase {

  constructor() VRFV2WrapperConsumerBase(linkAddress, wrapperAddress) {}

  function requestRandomWords() external returns (uint256 requestId) {
    requestId = requestRandomness(callbackGasLimit, requestConfirmations, numWords);
    requestStatuses[requestId] = RequestStatus(VRF_V2_WRAPPER.calculateRequestPrice(callbackGasLimit), false, new uint256[](0));
    requestIds.push(requestId);
    lastRequestId = requestId;
    return requestId;
  }

  function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
    require(requestStatuses[_requestId].paid > 0, "request not found");
    requestStatuses[_requestId].fulfilled = true;
    requestStatuses[_requestId].randomWords = _randomWords;
  }

  function getRequestStatus(uint256 _requestId) external view returns (uint256 paid, bool fulfilled, uint256[] memory randomWords) {
    require(requestStatuses[_requestId].paid > 0, "request not found");
    RequestStatus memory request = requestStatuses[_requestId];
    return (request.paid, request.fulfilled, request.randomWords);
  }

  address linkAddress = 0x326C977E6efc84E512bB9C30f76E30c160eD06FB;
  address wrapperAddress = 0x708701a1DfF4f478de54383E49a627eD4852C816;
  uint32 callbackGasLimit = 100000;
  uint16 requestConfirmations = 3;
  uint32 numWords = 2;

  struct RequestStatus {
    uint256 paid;
    bool fulfilled;
    uint256[] randomWords;
  }

  mapping(uint256 => RequestStatus) public requestStatuses;
  uint256[] public requestIds;
  uint256 public lastRequestId;

}