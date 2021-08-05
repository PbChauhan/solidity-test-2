const HDWalletProvider = require('truffle-hdwallet-provider');
const seed_phrase = 'old world suggest north glow hand people talk mean put menu erosion';
const infura_rinkeby_link = "https://rinkeby.infura.io/v3/99c6b310458f44d29b313ce0a1c4b6e9"
module.exports = {
  // See <http://truffleframework.com/docs/advanced/configuration>
  // for more about customizing your Truffle configuration!
  networks: {
    development: {
      host: "127.0.0.1",
      port: 7545,
      network_id: "*" // Match any network id
    },
    develop: {
      port: 8545
    },
    rinkeby: {
      provider: ()=> new HDWalletProvider(seed_phrase, infura_rinkeby_link),
      network_id: 4,
      gas: 5500000,
      confirmations: 2,
      timeoutBlocks: 2000000000000,
      skipDryRun: true
    }

  },
  compilers: {
    solc: {
      version: ">=0.4.22",    // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  }
};
