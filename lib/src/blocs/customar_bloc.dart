import 'package:MarketingApp/src/models/market.dart';
import 'package:MarketingApp/src/models/product.dart';
import 'package:MarketingApp/src/services/firestore_service.dart';

class CustomerBloc{
  final db = FirestoreService();

  //Get
  Stream<List<Market>> get fetchUpcomingMarkets => db.fetchUpcomingMarkets();
  Stream<List<Product>> get fetchAvailableProducts => db.fetchAvailableProducts();
  dispose(){
    
  }
}