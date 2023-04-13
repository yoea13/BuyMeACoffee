// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

// Tutorial
// https://www.youtube.com/watch?v=cxxKdJk55Lk

// Uncomment this line to use console.log
// import "hardhat/console.sol";

contract BuyMeACoffee {
    // Event to emit when a Memo is created
    event NewMemo(
        address indexed from,
        uint256 timestamp,
        string name,
        string message
    );

    //Memo struct.

    struct Memo {
        address from;
        uint256 timestamp;
        string name;
        string message;
    }
    //List of all memos
    Memo[] memos;

    //Address contract deployer
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    /**
     * @dev buy a coffee for contract owner
     * @param _name name of coffee buyer
     * @param _message a message from the buyer
     */
    function buyCoffee(
        string memory _name,
        string memory _message
    ) public payable {
        require(msg.value > 0, "can't buy coffee with 0 eth");
        // Add the memo to storage
        memos.push(Memo(msg.sender, block.timestamp, _name, _message));
        // Emit a log event when a new memo is created
        emit NewMemo(msg.sender, block.timestamp, _name, _message);
    }

    /**
     * @dev send balance to the ower
     */
    function withdrawTips() public {
        require(owner.send(address(this).balance));
    }

    /**
     * @dev retrieve all the memos
     */
    function getMemos() public view returns (Memo[] memory) {
        return memos;
    }
}
