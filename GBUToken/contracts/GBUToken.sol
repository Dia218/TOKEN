pragma solidity >=0.4.20;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUToken is StandardToken {//StandardToken을 상속하여 기능 활용
    string public constant name = 'GBU Data Links Token';
    string public constant symbol = 'GBU';
    uint8 public constant decimals = 2; //0.01단위로
    uint constant _initial_supply  = 2100000000;
    address public admin;   //토큰 쪽에도 컨트랙 만든 사람 인식할 수 있도록

    constructor() public {
        admin = msg.sender; 
        totalSupply_ = _initial_supply;	//totalSupply_는 BasicToken.sol에서
        balances[msg.sender] = _initial_supply;
        emit Transfer(address(0), msg.sender, _initial_supply);
    }

//- user가 다른 user와 token 거래 가능케 하는 기능 approval 이용?
    function approveToken(address _receiver, uint _limitValue, uint _value) public {  //토큰값 데이터 타입 자연수 uint로 
        require(_value <= _limitValue);
        approve(_receiver, _value); // receiver에게 sender의 계좌에서 value만큼 뺄 수 있는 권한을 줘라
    }
//- user들의 token 현황 관리 balanceOf 등 이용?
    function myToken(address _user) public view returns (uint256) {
        return balanceOf(_user);
    }

    function takeBackToken(address _user, uint256 _token) public onlyOwner{ //토큰 환수를 위한 기능 admin만 사용할 수 있도록 하고 internal
        require(_token <= balances[_user]); //사용자의 밸런스보다 작거나 같은 토큰량 검사
        balances[_user] = balances[_user].sub(_token);  //사용자 밸런스 감소
        balances[admin] = balances[admin].add(_token);  //admin 밸런스 증가
        emit Transfer(address(0), admin, _token);   //이에 대한 전송 이벤트를 admin(address(0))에게 전달)
    }
	modifier onlyOwner {	//기능 이름 onlyOnwer
		require(msg.sender == admin);
		_;	//모디파이어가 실제 실행되는 기능의 실제 코드에 해당되는 부분
	}
}
