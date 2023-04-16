require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");
require("@nomiclabs/hardhat-etherscan");
//require('@openzeppelin/hardhat-upgrades');
require("dotenv").config();

module.exports = {
  solidity: "0.8.19",
  // networks: {
  //   rinkeby: {
  //     url: `${process.env.POKT_RINKEBY_URL}`,
  //     accounts: [`${process.env.RINKEBY_PRIVATE_KEY}`],
  //   },
  // },
  // etherscan: {
  //   apiKey: process.env.ETHERSCAN_API_KEY,
  // },
};
