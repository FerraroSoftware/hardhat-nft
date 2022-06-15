// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@chainlink/contracts/src/v0.8/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract RandomIpfsNft is VRFConsumerBaseV2, ERC721 {
    // when we mint nft, trigger chainlink vrf to get us a random number
    // using that number, get a random nft
    // pug, shib, st benard
    // pug super rare
    // shib sort of rare
    // st bernard common

    // users have to pay to mint nft
    // owner of contract can withdraw eth

    VRFCoordinatorV2Interface private immutable i_vrfCoordinator;
    uint64 private immutable i_subscriptionId;
    bytes32 private immutable i_gasLane;
    uint32 private immutable i_callbackGasLimit;
    uint16 private constant REQUEST_CONFIRMATIONS = 3;
    uint32 private constant NUM_WORDS = 1;

    // VRF helpers
    mapping(uint256 => address) public s_requestIdToSender;

    // NFT Variables
    uint256 public s_tokenCounter;

    constructor(
        address vrfCoordinatorV2,
        uint64 subscriptionId,
        bytes32 gasLane, // keyHash
        uint256 mintFee,
        uint32 callbackGasLimit
    ) VRFConsumerBaseV2(vrfCoordinatorV2) ERC721("Random IPFS NFT", "RIN") {
        i_vrfCoordinator = VRFCoordinatorV2Interface(vrfCoordinatorV2);
        i_gasLane = gasLane;
        i_subscriptionId = subscriptionId;
        i_callbackGasLimit = callbackGasLimit;
    }

    function requestNft() public returns (uint256 requestId) {
        requestId = i_vrfCoordinator.requestRandomWords(
            i_gasLane,
            i_subscriptionId,
            REQUEST_CONFIRMATIONS,
            i_callbackGasLimit,
            NUM_WORDS
        );
        // will lose address if we dont store it
        s_requestIdToSender[requestId] = msg.sender;
    }

    function fullfillRandomWords(
        uint256 requestId,
        uint256[] memory randomWords
    ) internal {
        // safemint(msg.sender, s_tokencounter) !!! this would be the chainlink keeper responding
        // need to map request id and address of who called it, so when fullrandomwords, we have same requestid. use for
        // map to get address
        address dogOwner = s_requestIdToSender[requestId];
        uint256 newTokenId = s_tokenCounter;
        _safeMint(dogOwner, newTokenId);
    }

    function tokenURI(uint256) public view override returns (string memory) {}
}
