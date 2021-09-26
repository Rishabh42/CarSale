pragma solidity 0.8.4;

contract CarSale {
  address owner;

  constructor() {
    owner = msg.sender;
  }

  struct Car {
    uint256 price;
    address carAddress;
  }

  // Mapping to store inventory
  mapping(address => Car) public carDetails;
  // Mapping to store Car indexes
  mapping(address => uint256) public carIndex;

  address[] public inventory;
  Car[] public soldCars;

  event carAdded(uint256 _price, address _carAddr);
  event carSold(uint256 _price, address _carAddr);

  function newCar(uint256 _price, address _carAddr) public {
    // check if car doesn't exist already
    require(
      address(0) == carDetails[_carAddr].carAddress,
      "Car already exists"
    );
    // check if prize is zero
    require(_price != 0, "price is zero");

    Car memory _newCar;
    _newCar.price = _price;
    _newCar.carAddress = _carAddr;

    carDetails[_carAddr].price = _price;
    carDetails[_carAddr].carAddress = _carAddr;

    inventory.push(_carAddr);
    carIndex[_carAddr] = inventory.length - 1;
    emit carAdded(_price, _carAddr);
  }

  function buyCar(address _carAddr) public payable {
    // check if the car exists
    require(address(0) != carDetails[_carAddr].carAddress, "Car not found");

    uint256 carPrice = carDetails[_carAddr].price;
    uint256 _carIndex = carIndex[_carAddr];

    // ensure that the buyer has enough funds
    require(carPrice <= msg.sender.balance);

    Car memory _soldCar;
    _soldCar.price = carPrice;
    _soldCar.carAddress = _carAddr;

    // delete the car from inventory
    delete inventory[_carIndex];

    // store the car in the `carSold` array
    soldCars.push(_soldCar);
    emit carSold(carPrice, _carAddr);
  }

  function getInventory() public view returns (address[] memory) {
    return inventory;
  }

  function getSoldCars() public view returns (Car[] memory) {
    return soldCars;
  }
}
