// const hre = require("hardhat");
import hre from "hardhat";

async function main() {
    const Mint = await hre.ethers.getContractFactory("NFTMint");
    const mint = await Mint.deploy("0xB1e0B5d8E2C790f171bB421fAf13293DAbC9FD2C");

    //   await usdc.deployed();
    await mint.waitForDeployment();

    console.log(
        `NFT mint: ${await mint.getAddress()}`
    );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
