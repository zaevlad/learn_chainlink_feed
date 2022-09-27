// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

interface AccessControlled {
  function LINK (  ) external view returns ( address );
  function acceptOwnership (  ) external;
  function acceptPayeeship ( address _transmitter ) external;
  function addAccess ( address _user ) external;
  function billingAccessController (  ) external view returns ( address );
  function checkEnabled (  ) external view returns ( bool );
  function decimals (  ) external view returns ( uint8 );
  function description (  ) external view returns ( string memory);
  function disableAccessCheck (  ) external;
  function enableAccessCheck (  ) external;
  function getAnswer ( uint256 _roundId ) external view returns ( int256 );
  function getBilling (  ) external view returns ( uint32 maximumGasPrice, uint32 reasonableGasPrice, uint32 microLinkPerEth, uint32 linkGweiPerObservation, uint32 linkGweiPerTransmission );
  function getRoundData ( uint80 _roundId ) external view returns ( uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound );
  function getTimestamp ( uint256 _roundId ) external view returns ( uint256 );
  function hasAccess ( address _user, bytes memory _calldata ) external view returns ( bool );
  function latestAnswer (  ) external view returns ( int256 );
  function latestConfigDetails (  ) external view returns ( uint32 configCount, uint32 blockNumber, bytes16 configDigest );
  function latestRound (  ) external view returns ( uint256 );
  function latestRoundData (  ) external view returns ( uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound );
  function latestTimestamp (  ) external view returns ( uint256 );
  function latestTransmissionDetails (  ) external view returns ( bytes16 configDigest, uint32 epoch, uint8 round, int192 latestAnswer, uint64 latestTimestamp );
  function linkAvailableForPayment (  ) external view returns ( int256 availableBalance );
  function maxAnswer (  ) external view returns ( int192 );
  function minAnswer (  ) external view returns ( int192 );
  function oracleObservationCount ( address _signerOrTransmitter ) external view returns ( uint16 );
  function owedPayment ( address _transmitter ) external view returns ( uint256 );
  function owner (  ) external view returns ( address );
  function removeAccess ( address _user ) external;
  function requestNewRound (  ) external returns ( uint80 );
  function requesterAccessController (  ) external view returns ( address );
  function setBilling ( uint32 _maximumGasPrice, uint32 _reasonableGasPrice, uint32 _microLinkPerEth, uint32 _linkGweiPerObservation, uint32 _linkGweiPerTransmission ) external;
  function setBillingAccessController ( address _billingAccessController ) external;
  function setRequesterAccessController ( address _requesterAccessController ) external;
  function setValidatorConfig ( address _newValidator, uint32 _newGasLimit ) external;
  function transferOwnership ( address _to ) external;
  function transferPayeeship ( address _transmitter, address _proposed ) external;
  function transmitters (  ) external view returns ( address[] memory);
  function typeAndVersion (  ) external pure returns ( string memory );
  function validatorConfig (  ) external view returns ( address validator, uint32 gasLimit );
  function version (  ) external view returns ( uint256 );
  function withdrawFunds ( address _recipient, uint256 _amount ) external;
  function withdrawPayment ( address _transmitter ) external;
}

contract PriceConsumerV3{

    AggregatorV3Interface internal priceFeed;
    /**
     * Network: Goerli
     * Aggregator: ETH/USD
     * Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
     */
    AccessControlled internal AccessControl;
    
    constructor() {
        priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        AccessControl = AccessControlled(0xAe74faA92cB67A95ebCAB07358bC222e33A34dA7);
    }

    /**
     * Returns the latest price
     */
    function getLatestPrice() public view returns (int) {
        (
            /*uint80 roundId*/,
            int price,
            /*uint startedAt*/,
            /*uint timeStamp*/,
            /*uint80 answeredInRound*/
        ) = priceFeed.latestRoundData();
        return price;
    }

    function getDecimals() public view returns (uint8) {
        return priceFeed.decimals();

    }

    function getDecsription() public view returns (string memory) {
        return priceFeed.description();
    }

    
    function getVersion() public view returns (uint256) {
        return priceFeed.version();
    }

    function checkAccess() public view returns (uint256) {
        return AccessControl.version();
    }

}