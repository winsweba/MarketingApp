import 'package:MarketingApp/src/app.dart';
import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/blocs/product_bloc.dart';
import 'package:MarketingApp/src/models/product.dart';
import 'package:MarketingApp/src/models/user.dart';
import 'package:MarketingApp/src/styles/base.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:MarketingApp/src/widgets/button.dart';
import 'package:MarketingApp/src/widgets/dropdown_button.dart';
import 'package:MarketingApp/src/widgets/products.dart';
import 'package:MarketingApp/src/widgets/sliver_scaffold.dart';
import 'package:MarketingApp/src/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  final String productId;

  EditProduct({this.productId});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {

  @override
  void initState() {
    var productBloc = Provider.of<ProductBloc>(context, listen: false);
    productBloc.productSaved.listen((saved) { 
      if(saved != null && saved == true ) Navigator.of(context).pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return FutureBuilder<Product>( 
      future: productBloc.fetchProduct(widget.productId),
      builder: (context, snapshot ){

        if(!snapshot.hasData && widget.productId != null ){
          return Scaffold(
            body: Center(child: (Platform.isIOS) 
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(),),
          );
        }
     
      Product existingProduct;

      if(widget.productId != null){
        //Edit Logic
        existingProduct = snapshot.data;
        loadValus(productBloc, existingProduct, authBloc.userId);
      }else{
        // Addind Logic
        loadValus(productBloc, null, authBloc.userId);
      }

    return (Platform.isIOS) 
      ? AppSliverScafflod.cupertinoPageScaffold(
          navTitle: '',
          pageBody: pageBody(true, productBloc, context, existingProduct),
          context: context)
          : AppSliverScafflod.materialScaffold(
          navTitle: '',
          pageBody: pageBody(false, productBloc, context, existingProduct),
          context: context);
       

      });

      
  }

  Widget pageBody(bool isIOS, ProductBloc productBloc, BuildContext context, Product existingProduct) {
    var items = Provider.of<List<String>>(context);
    var pageLabel = (existingProduct != null) ? 'Edit Product' : 'Add Product';
    return ListView(
      children: <Widget>[
        Text(
          pageLabel,
          style: TextStyles.subTitle,
          textAlign: TextAlign.center,
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: Divider(color: AppColors.darkblue),
        ),
        StreamBuilder<String>(
            stream: productBloc.productName,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Product Name',
                cupertinoIcon: FontAwesomeIcons.shoppingBasket,
                materialIcon: FontAwesomeIcons.shoppingBasket,
                errorText: snapshot.error,
                initialText: (existingProduct != null)
                ? existingProduct.productName
                : null ,
                onChanged: productBloc.changeProductName,
              );
            }),
        StreamBuilder<String>(
            stream: productBloc.unitType,
            builder: (context, snapshot) {
              return AppDropdownButton(
                hintText: 'Unit Type',
                items: items,
                value: snapshot.data,
                materialIcon: FontAwesomeIcons.balanceScale,
                cupertinoIcon: FontAwesomeIcons.balanceScale,
                onChanged: productBloc.changeUnitType,
              );
            }),
        StreamBuilder<double>(
            stream: productBloc.unitPrice,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Unity Price',
                cupertinoIcon: FontAwesomeIcons.tag,
                materialIcon: FontAwesomeIcons.tag,
                textInputType: TextInputType.number,
                errorText: snapshot.error,
                initialText: (existingProduct != null)
                ? existingProduct.unitPrice.toString()
                : null ,
                onChanged: productBloc.changeUnitPrice,
              );
            }),
        StreamBuilder<int>(
            stream: productBloc.availableUnits,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Available Unity',
                cupertinoIcon: FontAwesomeIcons.cubes,
                materialIcon: FontAwesomeIcons.cubes,
                textInputType: TextInputType.number,
                errorText: snapshot.error,
                initialText: (existingProduct != null)
                ? existingProduct.availableUnits.toString()
                : null ,
                onChanged: productBloc.changeAvailableUnits,
              );
            }),
        AppButton( 
          buttonType: ButtonType.Straw, 
          buttonText: 'Add Image'),
        StreamBuilder<Object>(
          stream: productBloc.isValid,
          builder: (context, snapshot) {
            return AppButton( 
              buttonType: (snapshot.data == true) ? ButtonType.DarkBlue : ButtonType.Disabled, 
              buttonText: 'Save Product', 
              onPressed: productBloc.saveProduct,
              );
          }
        )
      ],
  

    );
    
  }

  loadValus(ProductBloc productBloc, Product product, String vendorId){
    productBloc.changeProduct(product);
    productBloc.chnageVendorId(vendorId);
    if(product != null){
      // Edit
      productBloc.changeUnitType(product.unitType);
      productBloc.changeProductName(product.productName);
      productBloc.changeUnitPrice(product.unitPrice.toString());
      productBloc.changeAvailableUnits(product.availableUnits.toString());
    }else{
      //Add
      productBloc.changeUnitType(null);
       productBloc.changeProductName(null);
      productBloc.changeUnitPrice(null);
      productBloc.changeAvailableUnits(null);
    }
  }

}
