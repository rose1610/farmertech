pragma solidity^0.4.26;
contract Farmertech {

struct farmer {
    uint id;
    string name;
    uint contactno;
    string crop;
    string location;
    uint benefitCount; }

struct admin {
    bool authorized;
     uint assign; }
      string bname;
  uint bamount;
  string str;

address public owner;

mapping(uint=>farmer)public farmers;
uint public farmerscount;

mapping(address => admin) public admins;

uint public totalbenefits=0;

modifier ownerOnly(){
    require(msg.sender == owner);
    _; }

constructor() public {
    owner = msg.sender;
   
    }

function addfarmer(string memory _name,uint _contactno,string memory _crop,string memory _location)  public {
    farmerscount++;
    farmers[farmerscount]=farmer(farmerscount,_name,_contactno,_crop,_location, 0);
   
}
function setbenefit(string memory  _bname,uint  _bamount) ownerOnly public {
       bname= _bname;
       bamount= _bamount;
   }
     function getbenefit() view public returns (string memory,uint){
       
       return (bname,bamount);
    }


function authorize (address _person) ownerOnly public {
    admins[_person].authorized = true; }

function assignbenefit (uint _farmerIndex,uint _count) public {
    if(bamount>totalbenefits)
  {
    require(admins[msg.sender].authorized);

    admins[msg.sender].assign = _farmerIndex;
 

    farmers[_farmerIndex].benefitCount += _count;
    totalbenefits += _count;
  }
  else
   {
         str="benefits over";
   }
   
}

   
    function end() ownerOnly public {
    selfdestruct(msg.sender); }

}
