import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class Prodlistmodel extends Model {
  List<Product> cart = [];
  double totalCartValue = 0;

  int get total => cart.length;

  void addProduct(pro) {
    int index = cart.indexWhere((i) => i.id == pro.id);
    print(index);
    if (index != -1) {
      updateProduct(pro, pro.itemOrderCount + 1);
    } else {
      pro.itemOrderCount = 1;
      cart.add(pro);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(pro) {
    int index = cart.indexWhere((i) => i.id == pro.id);
    cart[index].itemOrderCount = cart[index].itemOrderCount! - 1;
    if (cart[index].itemOrderCount == 0)
      cart.removeWhere((item) => item.id == pro.id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].itemOrderCount = qty;
    if (cart[index].itemOrderCount == 0) {
      removeProduct(product);
    }

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.quantity = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += (f.prize! * f.itemOrderCount!);
    });
  }
}

class Product {
  int? id;
  String? name;
  String? hindiname;
  String? imageurl;
  double? prize;
  String? unit;
  int? quantity;
  int? itemOrderCount;

  Product({
    this.id,
    this.name,
    this.hindiname,
    this.imageurl,
    this.prize,
    this.unit,
    this.quantity,
    this.itemOrderCount,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['productId'];
    name = json['name'];
    hindiname = json['hindiname'];
    imageurl = json['imageurl'];
    prize = json['prize'];
    unit = json['unit'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.id;
    data['name'] = this.name;
    data['hindiname'] = this.hindiname;
    data['imageurl'] = this.imageurl;
    data['prize'] = this.prize;
    data['unit'] = this.unit;
    data['quantity'] = this.quantity;
    return data;
  }
}
