// SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.4;

import "./openzeppelin-contracts/contracts/token/ERC1155/ERC1155.sol";

contract MyToken is ERC1155 {
    uint public constant myNFT = 0;
    uint public constant myFT = 1;
    uint public constant costFT = 1 ether;
    bool public auction = false;
    uint public auctionMoney = 20 ether;
    uint public bid = 0;
    address payable public owner;
    address payable public seller;
    address payable public candidate;
    address payable public winner;
    constructor () ERC1155("") {
        owner = payable(msg.sender);
        candidate = owner;
        _mint(owner, myNFT, 1, "");
        _mint(owner, myFT, 100000, "");
    }
    modifier admin() {
        require(msg.sender == owner);
        _;
    }
    function sellFT(uint _amount) public returns (bool) {
        if(_amount <= balanceOf(msg.sender, myFT)) {
            safeTransferFrom(msg.sender, owner, myFT, _amount, "");
            payable(msg.sender).transfer(_amount * costFT);
            return true;
        }
        return false;
    }
    function buyFT(uint _amount) external payable returns (bool) {
        if(msg.value >= _amount * costFT) {
            safeTransferFrom(owner, msg.sender, myFT, _amount, "");
            payable(msg.sender).transfer(msg.value - _amount * costFT);
            return true;
        }
        payable(msg.sender).transfer(msg.value);
        return false;
    }
    function buyNFTFrom(address _from) public payable returns (bool) {
        if(msg.value >= bid) {
            safeTransferFrom(_from, msg.sender, myNFT, 1, "");
            payable(_from).transfer(bid);
            payable(msg.sender).transfer(msg.value - bid);
            auction = false;
            return true;
        }
        payable(msg.sender).transfer(msg.value);
        return false;
    }
    function sellNFT() public returns (bool) {
        if(balanceOf(msg.sender, myNFT) > 0) {
            auction = true;
            return true;
        }
        return false;
    }
    function checkContractEther() public view admin returns (uint){
        return address(this).balance;
    }
    function setCandidate(uint _bid) public {
        candidate = payable(msg.sender);
        bid = _bid;
    }
    function declareWinner() public {
        winner = candidate;
        seller = payable(msg.sender);
    }
}