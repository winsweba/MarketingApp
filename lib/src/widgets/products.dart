import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/blocs/product_bloc.dart';
import 'package:MarketingApp/src/models/product.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:cupertino_toolbar/cupertino_toolbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Products extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    if(Platform.isIOS){
      return CupertinoPageScaffold(
        child: CupertinoToolbar( 
          items: <CupertinoToolbarItem>[
            CupertinoToolbarItem(icon: CupertinoIcons.add_circled, onPressed: () => Navigator.of(context).pushNamed('/editproduct')),
          ],
          body: pageBody(productBloc, context, authBloc.userId), 
          ),
           
        );
    }else{
      return Scaffold(
        body: pageBody(productBloc, context, authBloc.userId),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.straw,
          child: Icon(Icons.add),
          onPressed: () => Navigator.of(context).pushNamed('/editproduct')),
      );
    }
  }

  Widget pageBody(ProductBloc productBloc, BuildContext context, String vendorId ){
    return StreamBuilder<List<Product>>(
      stream: productBloc.productByVendorId(vendorId),
      builder: (context, snapshot) {
        if(!snapshot.hasData) return (Platform.isIOS)
        ? CupertinoActivityIndicator()
        : CircularProgressIndicator();

        return ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (context, index){
            var product = snapshot.data[index];
            return Text(product.productName);
          },
        );
      }
    );
  }
}