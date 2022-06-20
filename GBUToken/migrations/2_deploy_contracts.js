var GBUToken = artifacts.require("GBUToken");
var GBUTManager = artifacts.require("GBUTManager");
module.exports = function(deployer, network, accounts) {
  var owner = accounts[0];  //주인 지정
    // Deploy the METoken contract as our only task
  deployer.deploy(GBUToken, {from : owner}).then(function(){
      return deployer.deploy(GBUTManager, GBUToken.address, owner, 100000);//GBUToken의 주소 매개변수로 추가, 1회 인센티브 지급 제한량 설정
  });
};