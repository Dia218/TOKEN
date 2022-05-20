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
    function approveToken(address receiver, uint limitValue, uint value) public {
        require(value <= limitValue);
        approve(receiver, value); // receiver에게 sender의 계좌에서 value만큼 뺄 수 있는 권한을 줘라
    }
}
