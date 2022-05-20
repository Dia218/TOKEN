pragma solidity >=0.4.19;
import './GBUToken.sol';
import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUTManager {

	GBUToken public gbuToken;
	address public admin;
	uint256 private INCENTIVE_LIMIT;
	constructor(address _GBUToken, address _GBUTOwner,uint256 _incentivelimit) public { 		
		gbuToken = GBUToken(_GBUToken); 		
		admin = _GBUTOwner;
		INCENTIVE_LIMIT = _incentivelimit;				 	
	} 
	modifier onlyOwner {	//기능 이름 onlyOnwer
		require(msg.sender == admin);
		_;	//모디파이어가 실제 실행되는 기능의 실제 코드에 해당되는 부분
	}
	// REJECT any incoming ether
	function () external payable { revert(); }

	// 특정 사용자에게 인센티브 지급
	function putIncentive(address _user, uint256 _incentive) public onlyOwner{
		require(_incentive <= INCENTIVE_LIMIT);
		gbuToken.transferFrom(admin, _user, _incentive);
	}
	// 해당 유저의 balance 얻기
	function viewBalanceOf(address _user) public view returns (uint256){
		return gbuToken.balanceOf(_user);
	}
	// 특정 사용자의 토큰 환수 기능 일부만 회수하도록백엔드에선 요청만큼만 회수 초과만 체크하면 프론트에선 조절
	function takeBackIncentive(address _user, uint256 _amount) public onlyOwner{  //토큰값 데이터 타입 자연수 uint로
		//transferFrom 안에도 require문 존재하지만 일단 넣으려고 하다 오류 발생으로 일단 제거
		gbuToken.transferFrom(_user, admin, _amount);	//_incentive 가져오기
	}
	// 참여 사용자들에 대한 목록 관리 기능 
	function viewUser(address _user) view public returns (uint256[] memory){
		//유저에 대한 추가 정보(주어진 인센티브량gbuToken.balanceOf(_user), 더 허용된 인센티브량gbuToken.allowance(admin, _user) 등 원하는 정보 추가할것)
		uint256[] memory userinfo;
		userinfo[0] = gbuToken.balanceOf(_user);
		userinfo[1] = gbuToken.allowance(admin, _user);
		return userinfo;
	}
	// 사용자 추가/삭제 기능 프론트관련으로. 백엔드에선 허가와 토큰 환수 모두만? 기능 확인하는 방법??
	//사용자 추가기능
	function addUser(address _user) public onlyOwner{
		gbuToken.approve(_user, INCENTIVE_LIMIT);	//인센티브 제한만큼 허가
		//가스 필요하니 소량의 이더 제공 포함 필요?
		//eth.sendTransaction({from: eth.accounts[0], to: _user, value: web3.toWei(10, "ether")})

	}
	//사용자 삭제 기능
	function deleteUser(address _user) public onlyOwner{
		gbuToken.approve(admin, 0);	//허가량 0으로 
		takeBackIncentive(_user, gbuToken.balanceOf(_user));	//위 구현된 기능 사용해 전체 토큰 회수
	}
}
