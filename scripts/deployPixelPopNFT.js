const hre = require("hardhat");

async function main() {
  const PixelPopNFT = await hre.ethers.getContractFactory("PixelPopNFT");
  const pixelPopNFT = await PixelPopNFT.deploy();

  await pixelPopNFT.deployed();

  console.log("PixelPopNFT deployed to: ", pixelPopNFT.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
.then(()=> process.exit(0))
.catch((error) => {
  console.log(error);
  process.exit(1);
});
