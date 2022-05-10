pragma solidity >=0.4.19;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUTManager {

	GBUToken public gbuToken;
	address public admin;
	uint256 private INCENTIVE_LIMIT;
	constructor(address _GBUToken, address _GBUTOwner,uint8 _incentivelimit) public { 		
		gbuToken = StandardToken(_GBUToken); 		
		GBUTOwner = _GBUTOwner;
		INCENTIVE_LIMIT = _incentivelimit;				 	
	} 

	function withdraw(uint withdraw_amount) public {
    		require(withdraw_amount <= 1000);	//한번에 보낼 수 있는 제한량
		//GBUToken의 트랜스퍼폼 기능 사용
		GBUToken.transferFrom(GBUTOwner, msg.sender, withdraw_amount);
   	}

	// REJECT any incoming ether
	function () external payable { revert(); }

	// 특정 사용자에게 인센티브 지급
	function putIncentive(address _user, uint8 _incentive){
		require(_incentive <= INCETIVE_LIMIT);
		gbuToken.transferFrom(GBU_owner, _user,_incentive);
	}
	// 특정 사용자의 토큰 환수 기능
	function redemptionAll(address _addr) public{
		uint8 tmp = viewBalanceOf(_user);		// 1. 해당 사용자의 balance가져오기
		gbuToken.transferFrom(_user,GBU_owner,tmp);	// 2. balance 모두 가져오기
	}
	// 해당 유저의 balance 얻기
	function viewBalanceOf(address _user) view public return (uint256){
		return gbuToken.balanceOf(_user);
	}

}
