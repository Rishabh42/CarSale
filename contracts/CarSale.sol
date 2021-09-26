pragma solidity 0.8.4;

contract CarSale {
    address seller;

    struct Car {
        uint256 price;
        address carAddress;
    }

    // Mapping to store inventory
    mapping(address => Car) public carDetails;
    Car[] public inventory;

    event carAdded(uint256 _price, address _carAddr);

    function newCar(uint256 _price, address _carAddr) public {
        Car memory _newCar;
        _newCar.price = _price;
        _newCar.carAddress = _carAddr;

        carDetails[_carAddr].price = _price;
        carDetails[_carAddr].carAddress = _carAddr;

        inventory.push(_newCar);
        emit carAdded(_price, _carAddr);
    }
}
