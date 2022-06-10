pragma solidity >=0.4.20;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUToken is StandardToken {//StandardToken을 상속하여 기능 활용
    string public constant name = 'GBU Data Links Token';
    string public constant symbol = 'GBU';
    uint8 public constant decimals = 2; //0.01단위로
    uint constant _initial_supply  = 2100000000;
    address public admin;   //토큰 쪽에도 컨트랙 만든 사람 인식할 수 있도록
    event isTakeBack(address indexed from, address indexed to, uint256 value);
    constructor() public {
        admin = msg.sender; 
        totalSupply_ = _initial_supply;	//totalSupply_는 BasicToken.sol에서
        balances[msg.sender] = _initial_supply;
        emit Transfer(msg.sender, admin, _initial_supply); //처음에 전체 토큰이 컨트랙 생성자(자신)에게로 보내졌음을 나타내는 이벤트
    }

//- user가 다른 user와 token 거래 가능케 하는 기능 approve 이용
    function approveToken(address _receiver, uint _limitValue, uint _value) public {  //토큰값 데이터 타입 자연수 uint로 
        require(_value <= _limitValue);
        approve(_receiver, _value); // receiver에게 sender의 계좌에서 value만큼 뺄 수 있는 권한을 줘라
    }
//- user들의 token 현황 관리 balanceOf 등 이용
    function myToken(address _user) public view returns (uint256) {
        return balanceOf(_user);
    }
//토큰 환수를 위한 기능 admin만 사용할 수 있도록 하고 internal
    function takeBackToken(address _user, uint256 _token) public onlyOwner{ 
        require(_token <= balances[_user]); //사용자의 밸런스보다 작거나 같은 토큰량 검사
        balances[_user] = balances[_user].sub(_token);  //사용자 밸런스 감소
        balances[admin] = balances[admin].add(_token);  //admin 밸런스 증가
        emit isTakeBack(_user, admin, _token);   //이에 대한 전송 이벤트를 admin에게 전달)
    }
	modifier onlyOwner {	//기능 이름 onlyOnwer admin만 가능한 기능에 대해서 사용
		require(msg.sender == admin);
		_;	//모디파이어가 실제 실행되는 기능의 실제 코드에 해당되는 부분
	}
}
