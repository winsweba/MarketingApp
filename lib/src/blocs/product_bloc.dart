import 'dart:async';

import 'package:MarketingApp/src/models/product.dart';
import 'package:MarketingApp/src/services/firestore_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:uuid/uuid.dart';

class ProductBloc {
  final _productName = BehaviorSubject<String>();
  final _unitType = BehaviorSubject<String>();
  final _unitPrice = BehaviorSubject<String>();
  final _availableUnits = BehaviorSubject<String>();
  final _vendorId = BehaviorSubject<String>();

  final db = FirestoreService();
  var uuid = Uuid();

  //Get
  Stream<String> get productName => _productName.stream.transform(validateProductName);
  Stream<String> get unitType => _unitType.stream;
  Stream<double> get unitPrice => _unitPrice.stream.transform(validateUnitPrice);
  Stream<int> get availableUnits => _availableUnits.stream.transform(validateAvailableUnits);
  Stream<bool> get isValid => CombineLatestStream.combine4(
    productName, unitType, unitPrice, availableUnits, (a, b, c, d) => true);
  Stream<List<Product>> productByVendorId(String vendorId) => db.fatchProductsByVendorId(vendorId);

  //set
  Function(String) get changeProductName => _productName.sink.add;
  Function(String) get changeUnitType => _unitType.sink.add;
  Function(String) get changeUnitPrice => _unitPrice.sink.add;
  Function(String) get changeAvailableUnits => _availableUnits.sink.add;
  Function(String) get chnageVendorId => _vendorId.sink.add;

  dispose(){
    _productName.close();
    _unitType.close();
    _unitPrice.close();
    _availableUnits.close();
    _vendorId.close();
  }

  Future saveProduct() async{
    var product = Product(
      approved:  true,
      availableUnits: int.parse(_availableUnits.value),
      productId: uuid.v4(),
      productName: _productName.value.trim(),
      unitPrice: double.parse(_unitPrice.value),
      unitType: _unitType.value,
      vendorId: _vendorId.value,
    );

    return db.addProduct(product)
    .then((value) => print('Product Saved'))
    .catchError((error) => print(error));
  }

//Validation
  final validateUnitPrice = StreamTransformer<String,double>.fromHandlers(handleData: (unitPrice,sink){
    try{
      sink.add(double.parse(unitPrice));
    }catch(error){
      sink.addError("Must be a number");
    }
  } 
  );

  final validateAvailableUnits = StreamTransformer<String,int>.fromHandlers(handleData: (availableUnits,sink){
    try{
      sink.add(int.parse(availableUnits));
    }catch(error){
      sink.addError("Must be a hwole number");
    }
  } 
  );

  final validateProductName = StreamTransformer<String,String>.fromHandlers(handleData: (productName,sink){
   if(productName.length >= 3 && productName.length <= 20 ){
      sink.add(productName.trim());
    }
    else{
      if (productName.length < 3){
        sink.addError('3 Character Minimum');
      } else{
        sink.addError('20 Charater Maximum');
      }
    }
  } 
  );

}