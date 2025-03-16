// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.28;

contract StructContract {
    struct Product {
        uint id;
        string name;
        uint price;
        uint stock;
    }

    mapping(uint => Product) public products;


    struct Order {
        uint id;
        Product[] products;
        uint totalPrice;
        
    }

    mapping(uint => Order) public orders;

    function addProduct(uint _id, string memory _name, uint _price, uint _stock) public {
        Product memory product = Product(_id, _name, _price, _stock);
        products[_id] = product;
    }

    function checkProduct(uint _id) public view returns (Product memory) {
        Product memory product = products[_id];
        // return (product.id, product.name, product.price, product.stock);
        return product;
    }

    function createOrder(uint _id, uint[] memory _productIds) public {
        Product[] memory _products = new Product[](_productIds.length);
        uint totalPrice = 0;
        for (uint i = 0; i < _productIds.length; i++) {
            Product memory product = products[_productIds[i]];
            _products[i] = product;
            totalPrice += product.price;
        }
        Order memory order = Order(_id, _products, totalPrice);
        orders[_id] = order;
    }

    function checkOrder(uint _id) public view returns (Order memory) {
        Order memory order = orders[_id];
        return order;
    }   
}