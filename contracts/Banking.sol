pragma solidity ^0.8;
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
// SPDX-License-Identifier: MIT
contract Banking{
    IERC20 _token;
    event Registered(address _user_address , string _user_name);
    event Withdraw(address _from , string _to,uint256 _amount);
    event Deposit(string _from , uint256 _amount);
    event TransferSent(string _from , string _to , uint256 _amount);

    address payable public Owner = payable(msg.sender);

    address[] public all_adderss;
    uint256 _balance = 0;
    mapping(address => uint256) internal account_balance;
    mapping(address => string) user_name;
    mapping(string => address)  user_address;
    mapping(address => bool) internal status;

    // modifier checkAllowance(uint amount) {
    //     require(_token.allowance(msg.sender, address(this)) >= amount, "Error");
    //     _;
    // }

    modifier Register_check{

        require(status[msg.sender] == true , "You are not registered yet");
        _;
    }

    modifier value_deposit( uint256 _value){

        require(msg.value >= _value , "You have not enough money to deposit");
        _;
    }

    modifier value_withdraw( uint256 _value){

        require(account_balance[msg.sender] >= _value  , "You have not enough money to withdraw / transfer");
        _;
    }

    function DepositERC20( IERC20 token , uint256 _amount) Register_check public {
        uint256 erc20_balance = token.balanceOf(msg.sender);
        require(erc20_balance >= _amount , "There is not enough money in your wallet");

        IERC20(token).transferFrom( msg.sender , address(this) , _amount);
        account_balance[msg.sender] += _amount;

        emit Deposit(user_name[msg.sender], _amount);

    }

    function _balanceOf(IERC20 token) public view returns(uint256){

        return token.balanceOf(msg.sender);

    }

    function WithdrawERC20( IERC20 token , uint256 _amount) value_withdraw(_amount) Register_check public {
        uint256 erc20_balance = token.balanceOf(address(this));
        require(erc20_balance >= _amount , "There is not enough money left in the account");
        token.transfer( msg.sender , _amount);
        account_balance[msg.sender] -= _amount;

        emit Withdraw(address(this) , user_name[msg.sender] , _amount);

    }

    function TransferERC20( IERC20 token , string memory _to , uint256 _amount) value_withdraw(_amount) Register_check public {
        uint256 erc20_balance = token.balanceOf(address(this));
        require(erc20_balance >= _amount , "There is not enough money left in the account");

        IERC20(token).transferFrom( address(this) , user_address[_to] ,  _amount);
        account_balance[msg.sender] -= _amount;

        emit TransferSent(user_name[msg.sender] , _to , _amount);

    }

    function register(string memory _input_name) public returns(bool){
        require(status[msg.sender] == false , "You already registered");

        all_adderss.push(msg.sender);
        user_name[msg.sender] = _input_name;
        status[msg.sender] = true;

        user_address[_input_name] = msg.sender;

        emit Registered(msg.sender , _input_name);

    return status[msg.sender];
    }

    function check() public view returns(bool){

        return status[msg.sender];
    }

    function view_username() public view returns(string memory){

        return user_name[msg.sender];
    }

    function amount_view() public view returns(uint256){
        return all_adderss.length;
    }

    function balance_view() public view returns (uint256){
        return account_balance[msg.sender];
    }

}