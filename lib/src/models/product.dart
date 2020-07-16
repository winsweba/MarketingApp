
import 'package:flutter/material.dart';

class Product{
  final String productName;
  final String unitType;
  final double unitPrice;
  final int availableUnits;
  final String vendorId;
  final String productId;
  final String imageUrl;
  final bool approved;
  final String note;

  Product({ 
  @required this.productName, 
  @required this.unitType, 
  @required this.unitPrice, 
  @required this.availableUnits, 
  @required this.vendorId, 
  @required this.productId, 
  this.imageUrl = "", 
  @required this.approved, 
  this.note = "", 
  });

  Map<String, dynamic> toMap (){
    return{
      'productName': productName,
      'unitType' : unitType,
      'unitPrice' : unitPrice,
      'availableUnits' : availableUnits,
      'approved' : approved,
      'imageUrl' : imageUrl,
      'note' : note,
      'productId' : productId,
      'vendorId' : vendorId,
    };
  } 

  Product.fromFirestore(Map<String, dynamic> firestore)
  : productName = firestore['productName'],
    unitType = firestore['unitType'],
    unitPrice = firestore['unitPrice'],
    availableUnits = firestore['availableUnits'],
    approved = firestore['approved'],
    imageUrl = firestore['imageUrl'],
    note = firestore['note'],
    productId = firestore['productId'],
    vendorId = firestore['vendorId'];

}