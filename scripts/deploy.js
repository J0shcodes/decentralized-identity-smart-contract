const { ethers } = require("hardhat");

async function main() {
  const IndentityContract = await ethers.getContractFactory("IdentityManagement");

  const deployedIdentityContract = await IndentityContract.deploy();

  await deployedIdentityContract.deployed();

  console.log("Identity Management Contract Address:", deployedIdentityContract.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });