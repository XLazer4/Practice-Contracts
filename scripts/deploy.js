const { ethers, upgrades } = require("hardhat");

const main = async () => {
  const [deployer] = await hre.ethers.getSigners();
  const accountBalance = await deployer.getBalance();

  console.log("Deploying contracts with account: ", deployer.address);
  console.log("Account balance: ", accountBalance.toString());

  const ContractFactory = await hre.ethers.getContractFactory("v1");
  const Contract = await upgrades.deployProxy(ContractFactory, [4], {
    initializer: "initialise",
  });
  await Contract.deployed();

  console.log("Contract address: ", Contract.address);
};

const runMain = async () => {
  try {
    await main();
    process.exit(0);
  } catch (error) {
    console.log(error);
    process.exit(1);
  }
};

runMain();
