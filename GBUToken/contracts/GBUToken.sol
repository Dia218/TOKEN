pragma solidity >=0.4.20;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUToken is StandardToken {//StandardToken을 상속하여 기능 활용
    string public constant name = 'GBU Data Links Token';
    string public constant symbol = 'GBU';
    uint8 public constant decimals = 2;
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
    
//- user가 다른 여려 명의 user에게 token을 동시에 전송할 수 있는 기능(필요한지 생각) 프론트에서 여러 withdraw 해주는 게 좋지 않을까
/*    function manytrans(address[] memory receivers, uint[] memory values) public {
        for(uint i=0; i<receivers.length; i++) {
            trans(receivers[i], values[i]);
        }
    }
*/
//- user들의 token 현황 관리 balanceOf 등 이용?
    function myToken(address _user) public view returns (uint256) {
        return balanceOf(_user);
    }


    function takeBackToken(address _user, uint256 _token) public onlyOwner{ //토큰 환수를 위한 기능
        require(_token <= balances[_user]);
        balances[_user] = balances[_user].sub(_token);
        balances[admin] = balances[admin].add(_token);
        emit Transfer(address(0), admin, _token);
    }
	modifier onlyOwner {	//기능 이름 onlyOnwer
		require(msg.sender == admin);
		_;	//모디파이어가 실제 실행되는 기능의 실제 코드에 해당되는 부분
	}
}
