import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/widgets/orders.dart';
import 'package:MarketingApp/src/widgets/products_customer.dart';
import 'package:MarketingApp/src/widgets/products.dart';
import 'package:MarketingApp/src/widgets/profile.dart';
import 'package:MarketingApp/src/widgets/profile_customer.dart';
import 'package:MarketingApp/src/widgets/shopping_bag.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

abstract class CustomerScaffold {

  static CupertinoTabScaffold get cupertinoTabScaffold {
    return CupertinoTabScaffold(
      tabBar: _cupertinoTabBar, 
      tabBuilder: (contct, index) {
        return _pageSlection(index );
      }
      );
  }

  static get _cupertinoTabBar{
    return CupertinoTabBar(
      backgroundColor: AppColors.darkgrey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.create),title: Text('Product'),),
        BottomNavigationBarItem(icon: Icon(FontAwesomeIcons.shoppingBag), title : Text('Order'),),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),title: Text('Profile'),),
      ],
      );
  }
  static Widget _pageSlection(int index){
    if(index == 0){
      return ProductsCustomer();
    }

    if(index == 1){
     return ShoppingBag();
    }
    return ProfileCustomer();
  }
  
}