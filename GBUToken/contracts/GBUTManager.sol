pragma solidity >=0.4.19;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUTManager {

	StandardToken public GBUToken;
	address public GBUTOwner;
	constructor(address _GBUToken, address _GBUTOwner) public {
		GBUToken = StandardToken(_GBUToken);
		GBUTOwner = _GBUTOwner;
	}

	function withdraw(uint withdraw_amount) public {
    	require(withdraw_amount <= 1000);	//한번에 보낼 수 있는 제한량

		//GBUToken의 트랜스퍼폼 기능 사용
		GBUToken.transferFrom(GBUTOwner, msg.sender, withdraw_amount);
    }

	// REJECT any incoming ether
	function () external payable { revert(); }

//- 특정 사용자에게 인센티브 지급하는 기능 withdraw 이용?

//- 특정 사용자의 토큰 환수 기능 revert() 기능 이용?

//- 참여 사용자들에 대한 목록 관리 기능

//- 사용자 추가/삭제 기능

//- 참여 user들 중 인센티브 발급 받은 user들을 따로 관리하는 기능(고민요망)

}