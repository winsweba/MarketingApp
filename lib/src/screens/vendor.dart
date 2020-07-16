import 'dart:async';

import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/styles/tab_bar.dart';
import 'package:MarketingApp/src/widgets/navbar.dart';
import 'package:MarketingApp/src/widgets/orders.dart';
import 'package:MarketingApp/src/widgets/products.dart';
import 'package:MarketingApp/src/widgets/profile.dart';
import 'package:MarketingApp/src/widgets/vendor_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Vendor extends StatefulWidget{
  

  @override
  _VendorState createState() => _VendorState();

  static TabBar get vendorTabBar {
    return TabBar(
      unselectedLabelColor: TabBarStyle.unselectedLabelColor,
      labelColor: TabBarStyle.labelColor,
      indicatorColor: TabBarStyle.indicatorColor,
      tabs: <Widget> [ 
        Tab(icon: Icon(Icons.list)),
        Tab(icon: Icon(Icons.shopping_cart)),
        Tab(icon: Icon(Icons.person)),
      ] 
      );
  }
}

class _VendorState extends State<Vendor> {
  StreamSubscription _userSubscription;

  @override
  void initState() {
     Future.delayed(Duration.zero,(){
       var authBloc = Provider.of<AuthBloc>(context, listen: false);
       _userSubscription = authBloc.user.listen((user) {
         if(user == null ) Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
        });
     } 
     );
    super.initState();
  }

  @override
  void dispose() {
    _userSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
    if(Platform.isIOS) {
      return CupertinoPageScaffold(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget> [
              AppNavBar.cupertinoNavBar(title: 'Vendor Name',context: context ),
            ];
          }, 
          body: VendorScaffold.cupertinoTabScaffold, 
          ), 
          );
    }
    else{
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget> [
              AppNavBar.materialNavBar(title: 'Vendor Name', tabBar: Vendor.vendorTabBar),
            ];
          },
          body: TabBarView(children: <Widget>[
            Products(),
            Orders(),
            Profile(),
          ]),
          )
        ),
      );
    }
  }
}