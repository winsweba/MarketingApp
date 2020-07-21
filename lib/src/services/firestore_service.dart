// import 'dart:html';

import 'package:MarketingApp/src/models/product.dart';
import 'package:MarketingApp/src/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  Firestore _db = Firestore.instance;

  Future<void> addUser(User user){
    return _db
    .collection('users')
    .document(user.userId)
    .setData(user.toMap());
  }

  Future<Product> fetchProduct(String productId){
    return _db.collection('products').document(productId)
    .get().then((snapshot) => Product.fromFirestore(snapshot.data));
  }

  Future<User> fetchUser(String userId){
    return _db.collection('users').document(userId).get().then((snapshot) => User.fromFirestore(snapshot.data));
  }

  Stream<List<String>> fetchUnitTypes(){
    return _db.collection('types').document('units').snapshots()
    .map((snapshot) => snapshot.data['production']
    .map<String>((type) => type.toString()).toList());
  }

  Future<void> setProduct(Product product){
    return _db
    .collection('products')
    .document(product.productId)
    .setData(product.toMap());
  }

  Stream<List<Product>> fatchProductsByVendorId(String vendorId){
    return _db.collection('products')
          .where('vendorId', isEqualTo: vendorId)
          .snapshots()
          .map((query) => query.documents)
          .map((snapshot) => 
          snapshot.map((document) => Product.fromFirestore(document.data))
          .toList());
  }
}