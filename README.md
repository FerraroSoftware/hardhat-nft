3 Contracts

1. Basic NFT
2. Random IPFS NFT - random at creation time
3. Dynamic SVG NFT

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
