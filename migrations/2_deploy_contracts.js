var Banking = artifacts.require("Banking");
module.exports = function(deployer) {
    deployer.deploy(Banking, "Banking");
    // Additional contracts can be deployed here
};