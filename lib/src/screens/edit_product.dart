import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/blocs/product_bloc.dart';
import 'package:MarketingApp/src/models/user.dart';
import 'package:MarketingApp/src/styles/base.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:MarketingApp/src/widgets/button.dart';
import 'package:MarketingApp/src/widgets/dropdown_button.dart';
import 'package:MarketingApp/src/widgets/sliver_scaffold.dart';
import 'package:MarketingApp/src/widgets/textfield.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  @override
  Widget build(BuildContext context) {
    var productBloc = Provider.of<ProductBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return StreamProvider( 
      create: (context) => authBloc.user, 
      child: (Platform.isIOS) 
      ? AppSliverScafflod.cupertinoPageScaffold(
          navTitle: '',
          pageBody: pageBody(true, productBloc, context),
          context: context)
          : AppSliverScafflod.materialScaffold(
          navTitle: '',
          pageBody: pageBody(false, productBloc, context),
          context: context),);

  }

  Widget pageBody(bool isIOS, ProductBloc productBloc, BuildContext context) {
    var items = Provider.of<List<String>>(context);
    return Consumer<User>( 
      builder: (_,user,__){
        if(user != null ) productBloc.chnageVendorId(user.userId);
        return (user != null ) ? ListView(
      children: <Widget>[
        Text(
          'Add Product',
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
    ) : Container();

      });
    
  }
}
