import 'package:MarketingApp/src/widgets/navbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class AppSliverScafflod {
  static CupertinoPageScaffold cupertinoPageScaffold({String navTitle, Widget pageBody, BuildContext context}) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppNavBar.cupertinoNavBar(title: navTitle,context: context ),
          ];
        },
        body: pageBody,
      ),
    );
  }

  static Scaffold materialScaffold({String navTitle, Widget pageBody, BuildContext context}) {
    return Scaffold(
      body:  NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget> [
              AppNavBar.materialNavBar(title: navTitle, pinned: false),
            ];
          },
          body: pageBody,
          ),
    );
  } 
}
