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

	// 특정 사용자의 토큰 환수 기능 일부만 회수하도록 백엔드에선 요청만큼만 회수 초과만 체크하면 프론트에선 조절
	// GBUToken.sol로 이동

	// 해당 유저의 balance 얻기
	function viewBalanceOf(address _user) view public returns (uint256){
		return gbuToken.balanceOf(_user);
	}
/*
 // 참여 사용자들에 대한 목록 관리 기능 
	function viewUser(address _user) public returns (uint256[] memory){
		//유저에 대한 추가 정보(주어진 인센티브량gbuToken.balanceOf(_user), 더 허용된 인센티브량gbuToken.allowance(admin, _user) 등 원하는 정보 추가할것)
		uint256[] memory userinfo;
		userinfo[0] = gbuToken.balanceOf(_user);
		userinfo[1] = gbuToken.allowance(admin, _user);
		return userinfo;
	}*/

    // 사용자 추가/삭제 기능 프론트관련으로. 백엔드에선 허가와 토큰 환수 모두만? 기능 확인하는 방법??
	//사용자 추가기능
	/*function addUser(address _user) public onlyOwner{
		gbuToken.approve(_user, INCENTIVE_LIMIT);	//인센티브 제한만큼 허가
		//가스 필요하니 소량의 이더 제공 포함 필요?
		//eth.sendTransaction({from: eth.accounts[0], to: _user, value: web3.toWei(10, "ether")})
	*/
	//사용자 삭제 기능
	/*function deleteUser(address _user) public onlyOwner{
		gbuToken.approve(admin, INCENTIVE_LIMIT);
	}*/
}
