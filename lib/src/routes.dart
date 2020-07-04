import 'package:MarketingApp/src/screens/landing.dart';
import 'package:MarketingApp/src/screens/login.dart';
import 'package:MarketingApp/src/screens/signup.dart';
import 'package:MarketingApp/src/screens/vendor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


abstract class Routes {

  static MaterialPageRoute materialRoutes( RouteSettings settings){
    switch(settings.name){
      case "/landing":
      return MaterialPageRoute(builder: (context) => Landing());
      case "/signup":
      return MaterialPageRoute(builder: (context) => Signup());
      case "/login":
      return MaterialPageRoute(builder: (context) => Login());
        case "/vindor":
      return MaterialPageRoute(builder: (context) => Vendor());
      default:
      return MaterialPageRoute(builder: (context) => Login());
    }
  }

  static CupertinoPageRoute cupertinoRoutes( RouteSettings settings){
    switch(settings.name){
      case "/landing":
      return CupertinoPageRoute(builder: (context) => Landing());
      case "/signup":
      return CupertinoPageRoute(builder: (context) => Signup());
      case "/login":
      return CupertinoPageRoute(builder: (context) => Login());
      default:
      return CupertinoPageRoute(builder: (context) => Login());
    }
  }
}