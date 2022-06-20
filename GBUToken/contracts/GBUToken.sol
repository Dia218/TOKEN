pragma solidity >=0.4.20;

//오픈 재플린. npm i openzeppelin-solidity@1.12.0 사용
//이후 버전에 StandardToken.sol 사라져 이 버전을 이용하며 node_modules/openzeppelin-solidity/contracts/token/ERC20 폴더의 파일에서
//필요 파일들에 대한 추가적인 pragma solidity 버전 명시 및 컴파일러 버전 수정 필요. ex) pragma solidity ^0.5.16;
import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol'; 	

contract GBUToken is StandardToken {//StandardToken을 상속하여 기능 활용
    string public constant name = 'GBU Data Links Token';   //임의 컨트랙 이름
    string public constant symbol = 'GBU';  //임의 토큰 기호
    uint8 public constant decimals = 2; //임의 0.01단위로 
    uint constant _initial_supply  = 2100000000;    //임의 최초 토큰량
    address public admin;   //토큰 쪽에도 컨트랙 만든 사람 인식할 수 있도록 주소 저장(migrations 참고)
    event isTakeBack(address indexed from, address indexed to, uint256 value);  //토큰 환수에 대한 추가 이벤트(수정 및 인덱스 변수 추가 가능)

    constructor() public {
        admin = msg.sender; 
        totalSupply_ = _initial_supply;	//totalSupply_는 BasicToken.sol에서 상속받은 변수
        balances[msg.sender] = _initial_supply;
        emit Transfer(msg.sender, admin, _initial_supply); //처음에 전체 토큰이 컨트랙 생성자(자신)에게로 보내졌음을 나타내는 이벤트
    }

    // REJECT any incoming ether
	function() payable external {revert();}	//안에 ; 안붙이면 컴파일 에러

    //모디파이어 onlyOnwer: admin만 가능한 기능에 대해서 사용
	modifier onlyOwner {	
		require(msg.sender == admin);
		_;	//모디파이어가 실제 실행되는 기능의 실제 코드에 해당되는 부분
	}
    //- user가 다른 user와 token 거래 가능케 하는 기능 approve 이용(기존 approve와의 차이는 1회 허용량 설정)
    function approveToken(address _receiver, uint _limitValue, uint _value) public {  //토큰값 데이터 타입 자연수 uint로 
        require(_value <= _limitValue);
        approve(_receiver, _value); // receiver에게 sender의 지갑에서 value만큼 뺄 수 있는 권한을 부여
    }
    //- user들의 token 현황 관리 balanceOf 등 이용(balanceOf만을 그냥 사용해도 무방)
    function myToken(address _user) public view returns (uint256) {
        return balanceOf(_user);
    }
    //토큰 환수를 위한 추가 기능. admin만 사용할 수 있도록 함. 해당 사용자의 approve 없이도 admin의 권한으로 토큰을 환수하는 개념
    function takeBackToken(address _user, uint256 _token) public onlyOwner{ 
        require(_token <= balances[_user]); //사용자의 밸런스보다 작거나 같은 토큰량 검사
        balances[_user] = balances[_user].sub(_token);  //사용자 밸런스 감소
        balances[admin] = balances[admin].add(_token);  //admin 밸런스 증가
        emit isTakeBack(_user, admin, _token);   //이에 대한 전송 이벤트를 admin에게 전달)
    }
}
