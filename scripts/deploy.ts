// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import { artifacts, ethers } from "hardhat";
import { TREToken } from "../typechain-types/contracts/TREToken";

async function main() {
  // Hardhat always runs the compile task when running scripts with its command
  // line interface.
  //
  // If this script is run directly using `node` you may want to call compile
  // manually to make sure everything is compiled
  // await hre.run('compile');

  // We get the contract to deploy
  
  const treToken = await deployTREToken()
  saveABI(treToken)
}

async function deployTREToken(): Promise<TREToken> {
  const TREToken = await ethers.getContractFactory("TREToken");
  const treToken = await TREToken.deploy(1000);
  
  await treToken.deployed();
  return treToken
}

function saveABI(token: TREToken) {
  const fs = require("fs");
  const contractsDir = __dirname + "/abi/contracts";

  if (!fs.existsSync(contractsDir)) {
    fs.mkdirSync(contractsDir);
  }

  fs.writeFileSync(
    contractsDir + "/contract-address.json",
    JSON.stringify({ TREToken: token.address }, undefined, 2)
  );

  const TRETokenArtifact = artifacts.readArtifactSync("TREToken");

  fs.writeFileSync(
    contractsDir + "/TREToken.json",
    JSON.stringify(TRETokenArtifact, null, 2)
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
