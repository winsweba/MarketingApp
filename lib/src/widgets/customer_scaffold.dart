import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/widgets/orders.dart';
import 'package:MarketingApp/src/widgets/products.dart';
import 'package:MarketingApp/src/widgets/profile.dart';
import 'package:flutter/cupertino.dart';

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
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart),title: Text('Order'),),
        BottomNavigationBarItem(icon: Icon(CupertinoIcons.person),title: Text('Profile'),),
      ],
      );
  }
  static Widget _pageSlection(int index){
    if(index == 0){
      return Products();
    }

    if(index == 1){
     return Orders();
    }
    return Profile();
  }
  
}