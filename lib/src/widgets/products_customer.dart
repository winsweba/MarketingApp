import 'dart:io';

import 'package:MarketingApp/src/blocs/customar_bloc.dart';
import 'package:MarketingApp/src/models/product.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProductsCustomer extends StatelessWidget {
  final formatCurrency = NumberFormat.simpleCurrency();
  @override
  Widget build(BuildContext context) {
    var customerBloc = Provider.of<CustomerBloc>(context);
    
    return StreamBuilder<List<Product>>(
      stream: customerBloc.fetchAvailableProducts,
      builder: (context, snapshot) {
        
        if (!snapshot.hasData) return Center(child: (Platform.isIOS) ? CupertinoActivityIndicator() : CircularProgressIndicator() );
        
        return Scaffold(
          body: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  
                  itemCount: snapshot.data.length,
                  itemBuilder: (context,index ){
                    var product = snapshot.data[index];

                    return Column(
                      children: <Widget>[
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: (product.imageUrl !='') 
                            ? NetworkImage(product.imageUrl) 
                            : AssetImage('assets/images/image.jpg'),
                            radius: 25.0,
                          ),
                          title: Text(product.productName, style: TextStyles.listTitle,),
                          subtitle: Text("The Vender"),
                          trailing: Text('${formatCurrency.format(product.unitPrice)}/${product.unitType}', style: TextStyles.bodyLightBlue,),
                        ),
                        Divider(color: AppColors.lightgrey)
                      ],
                    );
                  }
                ),
              ),
              Container(
                height: 50.0,
                width: double.infinity,
                color: AppColors.straw,
                child: (Platform.isIOS)
                ? Icon(IconData(0xf388, fontFamily: CupertinoIcons.iconFont, fontPackage: CupertinoIcons.iconFontPackage ),color: Colors.white, size: 35.0,)
                : Icon(Icons.filter_list,color: Colors.white, size: 35.0,),
              )
            ],
          ),
        );
      }
    );
  }
}