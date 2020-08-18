import 'package:MarketingApp/src/models/market.dart';
import 'package:MarketingApp/src/services/firestore_service.dart';

class CustomerBloc{
  final db = FirestoreService();

  //Get
  Stream<List<Market>> get fetchUpcomingMarkets => db.fetchUpcomingMarkets();

  dispose(){
    
  }
}