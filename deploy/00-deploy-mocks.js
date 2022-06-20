const { getNamedAccounts, deployments, network, ethers } = require("hardhat");
const { developmentChains } = require("../helper-hardhat-config");

// const BASE_FEE = "250000000000000000"; // 0.25 is this the premium in LINK?
const BASE_FEE = ethers.utils.parseEther("0.2"); // 0.25 is this the premium in LINK?
const GAS_PRICE_LINK = 1e9; // link per gas, is this the gas lane? // 0.000000001 LINK per gas
const DECIMALS = "18";
const INITIAL_PRICE = ethers.utils.parseUnits("2000", "ether");

// Chainlink nodes pay the gas fees to give us randomness and do external execution
// price of requests change based on the price of gas

module.exports = async ({ getNamedAccounts, deployments }) => {
  const { deploy, log } = deployments;
  const { deployer } = await getNamedAccounts();
  const chainId = network.config.chainId;

  //  if (developmentChains.includes(network.name)){
  //  }

  // If we are on a local development network, we need to deploy mocks!
  if (chainId == 31337) {
    log("Local network detected! Deploying mocks...");
    await deploy("VRFCoordinatorV2Mock", {
      from: deployer,
      log: true,
      args: [BASE_FEE, GAS_PRICE_LINK],
    });
    await deploy("MockV3Aggregator", {
      from: deployer,
      log: true,
      args: [DECIMALS, INITIAL_PRICE],
    });

    log("Mocks Deployed!");
    log("----------------------------------------------------------");
    log(
      "You are deploying to a local network, you'll need a local network running to interact"
    );
    log(
      "Please run `yarn hardhat console --network localhost` to interact with the deployed smart contracts!"
    );
    log("----------------------------------------------------------");
  }
};
module.exports.tags = ["all", "mocks"];
