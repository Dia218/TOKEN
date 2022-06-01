pragma solidity >=0.4.19;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUTManager {
	StandardToken public gbuToken;	//GBUToken 기능 쓰기 위한 객체
	address public admin;	//컨트랙을 만든 주인EOA 주소
	uint256 private INCENTIVE_LIMIT;	//1회 인센티브 지급 제한량
	constructor(address _GBUToken, address _admin, uint256 _incentivelimit) public { 		
		gbuToken = StandardToken(_GBUToken); 		
		admin = _admin;
		INCENTIVE_LIMIT = _incentivelimit;
		//gbuToken.approve(_GBUTManager, gbuToken.totalSupply());		
		//GBUTManager가 admin의 토큰을 사용할 수 있도록 허가한다.
	}

	// REJECT any incoming ether
	function() payable external {revert();}	//안에 ; 안붙이면 컴파일 에러

	modifier onlyOwner {	//기능 이름 onlyOnwer
		require(msg.sender == admin);
		_;	//모디파이어가 실제 실행되는 기능의 실제 코드에 해당되는 부분
	}

	// 특정 사용자에게 인센티브 지급
	function putIncentive(address _user, uint256 _incentive) public {
		require(_incentive <= INCENTIVE_LIMIT); 		//인센티브 제한은 일단 고정으로
		gbuToken.transferFrom(admin, _user, _incentive);	//admin의 토큰을 사용자에게로 GBUTManager에게 전송 요청
		//해당 사용자에게 tokenManager가 자신의 토큰을 회수할 수 있도록 허가하라는 이벤트 메시지?
	}
	//사용자간의 인센티브 전송을 위한 transferFrom필요(GBUTManager에 대해 approve하므로 이쪽에 필요)
	function sendIncentive(address _from, address _to, uint256 _incentive) public {
		require(_incentive <= INCENTIVE_LIMIT); 		//인센티브 제한은 일단 고정으로
		gbuToken.transferFrom(_from, _to, _incentive);	//_user의 토큰을 사용자에게로 GBUTManager에게 전송 요청
		//해당 사용자에게 tokenManager가 자신의 토큰을 회수할 수 있도록 허가하라는 이벤트 메시지?
	}	
	// 특정 사용자의 토큰 환수 기능 일부만 회수하도록 백엔드에선 요청만큼만 회수 초과만 체크하면 프론트에선 조절
	// GBUToken.sol로 이동

	// 해당 유저의 balance 얻기
	function viewBalanceOf(address _user) view public returns (uint256){
		return gbuToken.balanceOf(_user);
	}
}
