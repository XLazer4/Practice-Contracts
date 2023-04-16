const { ethers, upgrades } = require("hardhat");

const proxy = "0xA4963cBf35B83C0f3836956213D3b8CB9ca5B3b5";

async function main() {
    const contractfactory = await ethers.getContractFactory("v2");
    await upgrades.upgradeProxy(proxy, contractfactory);
    console.log("upgraded");
}

main();