import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/routes.dart';
import 'package:MarketingApp/src/screens/landing.dart';
import 'package:MarketingApp/src/screens/login.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final authBloc = AuthBloc();

  @override
  Widget build(BuildContext context) {
    return MultiProvider( 
      providers: [
        Provider(create: (context) => authBloc,), 
        FutureProvider(create: (context) => authBloc.isLoggedIn()),
      ],
      child: PlatformApp());
  }
@override
  void dispose() {
    authBloc.dispose();
    super.dispose();
  }

}

class PlatformApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var isLoggedIn = Provider.of<bool>(context);

    if (Platform.isIOS) {
      return CupertinoApp(
        home: (isLoggedIn == null) ? loadingScreen(true) : (isLoggedIn == true) ? Landing() : Login(),
        onGenerateRoute: Routes.cupertinoRoutes,
        theme: CupertinoThemeData(
          primaryColor: AppColors.straw,
          scaffoldBackgroundColor: Colors.white,
          textTheme: CupertinoTextThemeData(
            tabLabelTextStyle: TextStyles.suggestions,
          )
        ),
      );
    } else {
      return MaterialApp(
        home: (isLoggedIn == null) ? loadingScreen(false) : (isLoggedIn == true) ? Landing() : Login(),
        onGenerateRoute: Routes.materialRoutes,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
        ),
      );
    }
  }

  Widget loadingScreen(bool isIOS) {
    return (isIOS)
    ? CupertinoPageScaffold(child: Center(child: CupertinoActivityIndicator(),))
    : Scaffold(body: Center(child: CircularProgressIndicator(),));
  }
}
