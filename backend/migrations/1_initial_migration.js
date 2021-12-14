const Migrations = artifacts.require("Migrations");
const Ethereum = artifacts.require("Ethereum")

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(Ethereum);
};
