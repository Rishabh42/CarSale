pragma solidity 0.8.4;

contract CarSale {
    address owner;
    
    constructor() {
        owner = msg.sender;
    }
    
    struct Car{
        uint256 price;
        address carAddress;
    }
    
    // Mapping to store inventory
    mapping (address => Car) public carDetails;
    Car[] public inventory;
    Car[] public soldCars;
    
    event carAdded(uint256 _price, address _carAddr);
    event carSold(uint256 _price, address _carAddr);
    
    function newCar(uint256 _price, address _carAddr) public {
        require(address(0) == carDetails[_carAddr].carAddress,"Car already exists");
        Car memory _newCar;
        _newCar.price = _price;
        _newCar.carAddress = _carAddr;
        
        carDetails[_carAddr].price = _price;
        carDetails[_carAddr].carAddress = _carAddr;
        
        inventory.push(_newCar);
        emit carAdded(_price, _carAddr);
    }
    
    function buyCar(address _carAddr) public payable{
        // check if the car exists
        require(address(0) != carDetails[_carAddr].carAddress,"Car not found");
        
        uint carPrice = carDetails[_carAddr].price;
        
        // ensure that the buyer has enough funds
        require (carPrice <= msg.sender.balance);
        
        Car memory _soldCar;
        _soldCar.price = carPrice;
        _soldCar.carAddress = _carAddr;
        //payable(address(this)).transfer(amount);
        
        soldCars.push(_soldCar);
        emit carSold(carPrice,_carAddr);
    }
    
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
    
    function withdraw() public {
       payable(msg.sender).transfer(address(this).balance);
    }
    
    function invest () external payable {
        
    }
}