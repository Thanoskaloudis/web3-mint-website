require("@nomicfoundation/hardhat-toolbox");
const dotenv = require("dotenv");

dotenv.config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.17",
  networks: {
    goerli: {
      url: `https://eth-goerli.alchemyapi.io/v2/${process.env.WEB3_APP_GOERLI_RPC_KEY}`,
      accounts: [process.env.WEB3_APP_PRIVATE_KEY]
    }
  },
  etherscan: {
    apiKey: process.env.WEB3_APP_ETHERSCAN_KEY
  }
};
