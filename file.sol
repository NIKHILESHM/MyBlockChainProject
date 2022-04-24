pragma solidity ^0.5.0;

//author Nikhilesh

contract OrganicFarmingApplication {
    mapping (address => uint) wallet;

    function addBuyer(address addr, uint money) public{
        wallet[addr] = money;
    }

    function getWalletBalance(address addr) view public returns(uint){
        return wallet[addr];
    }

struct farmer {
   
    uint farmerid;
    string farmername;
    string location;
    string crop;
    uint contact;
    uint quantity;
    uint price;
}

struct order {

    uint orderno;
    uint farmer;
    uint qty;
    address consumer;
}

mapping (uint => farmer) farmerMapping;
farmer[] public farmers;

mapping (uint => order) orderMapping;
order[] public orders;



function addFarmerProduce(uint id, string memory name, string memory location, string memory crop, uint contactNo, uint quantity, uint price) public{
               
        OrganicFarmingApplication.farmer memory fnew = farmer(id,name,location,crop,contactNo,quantity,price);
        farmerMapping[id] = fnew;
        farmers.push(fnew);
  
}
    
 function getFarmerProduce(uint j) public view returns(uint,string memory,string memory,string memory,uint,uint,uint) {
        return (farmerMapping[j].farmerid,farmerMapping[j].farmername,farmerMapping[j].location,farmerMapping[j].crop,farmerMapping[j].contact,farmerMapping[j].quantity,farmerMapping[j].price);
    }

 function placeorder(uint oid, uint farmerId, uint quantity, address buyer) public returns(bool sufficient){
     if (farmerMapping[farmerId].quantity < quantity) 
        return false;
     uint totalPrice = quantity * farmerMapping[farmerId].price;
     if (wallet[buyer] < totalPrice) 
        return false;
     farmerMapping[farmerId].quantity -= quantity;
     wallet[buyer] -= totalPrice;
     OrganicFarmingApplication.order memory neworder=order(oid,farmerId,quantity,buyer);
     orderMapping[oid]=neworder;
     orders.push(neworder);
     return true;
  
 }  
 function getorder(uint oid) public view returns(uint,uint,uint,address) {
     return(orderMapping[oid].orderno,orderMapping[oid].farmer,orderMapping[oid].qty,orderMapping[oid].consumer);
     
 }
}
