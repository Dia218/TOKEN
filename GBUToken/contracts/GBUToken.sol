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

//- user가 다른 여려 명의 user에게 token을 동시에 전송할 수 있는 기능(필요한지 생각) 프론트에서 여러 withdraw 해주는 게 좋지 않을까

//- user들의 token 현황 관리 balanceOf 등 이용?

}