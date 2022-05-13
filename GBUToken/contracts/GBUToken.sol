pragma solidity >=0.4.20;

import 'openzeppelin-solidity/contracts/token/ERC20/StandardToken.sol';

contract GBUToken is StandardToken {
    string public constant name = 'GBU Data Links Token';
    string public constant symbol = 'GBU';
    uint8 public constant decimals = 2;
    uint constant _initial_supply  = 2100000000;

    constructor() public {
        totalSupply_ = _initial_supply;
        balances[msg.sender] = _initial_supply;
        emit Transfer(address(0), msg.sender, _initial_supply);
    }

//- user가 다른 user와 token 거래 가능케 하는 기능 approval 이용?
    function trans(address receiver, uint limitValue, uint value) public {
        require(value <= limitValue);
        approve(receiver, value); // receiver에게 sender의 계좌에서 value만큼 뺄 수 있는 권한을 줘라
        // transfer(receiver, value);
    }
    
//- user가 다른 여려 명의 user에게 token을 동시에 전송할 수 있는 기능(필요한지 생각) 프론트에서 여러 withdraw 해주는 게 좋지 않을까
/*    function manytrans(address[] memory receivers, uint[] memory values) public {
        for(uint i=0; i<receivers.length; i++) {
            trans(receivers[i], values[i]);
        }
    }
*/
//- user들의 token 현황 관리 balanceOf 등 이용?
    function myToken(address user) public view returns (uint256) {
    return balanceOf(user);
  }
}
