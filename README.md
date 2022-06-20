3 Contracts

1. Basic NFT
2. Random IPFS NFT - random at creation time

- Pros: Cheap
- Cons: Someone needs to pin our data

3. Dynamic SVG NFT

- Pros: Data is on chain
- Cons: Expensive!

If price of ETH is above X -> Happy Face
Else below -> Frowny Face

## Current Issues

### 1.

~~BigNumber Issue~~

```
hh deploy --tags randomipfs,mocks
```

Currenty fails with:
Error: ERROR processing hardhat-nft/deploy/02-deploy-random-ipfs-nft.js:
Error: invalid BigNumber value (argument="value", value=undefined, code=INVALID_ARGUMENT, version=bignumber/5.6.2)

**Resolution:**
Missing mintFee in `helper-hardhat-config.js`

### 2.

Dynamic NFT test failing

```
  Error: call revert exception; VM Exception while processing transaction: reverted with reason string "URI Query for nonexistent token.
```
