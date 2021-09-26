const CarSale = artifacts.require("CarSale");

module.exports = function (deployer) {
  deployer.deploy(CarSale);
};
