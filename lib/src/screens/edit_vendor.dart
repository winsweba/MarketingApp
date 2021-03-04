import 'dart:async';
import 'dart:io';

import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/blocs/vendor_bloc.dart';
import 'package:MarketingApp/src/models/vendor.dart';
import 'package:MarketingApp/src/styles/base.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:MarketingApp/src/widgets/button.dart';
import 'package:MarketingApp/src/widgets/sliver_scaffold.dart';
import 'package:MarketingApp/src/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class EditVendor extends StatefulWidget {
  final String vendorId;

  EditVendor({this.vendorId});
  @override
  _EditVendorState createState() => _EditVendorState();
}

class _EditVendorState extends State<EditVendor> {
  StreamSubscription _saveSubscription;

  @override
  void initState() {
    var vendorBloc = Provider.of<VendorBloc>(context, listen: false);
    _saveSubscription = vendorBloc.vendorSaved.listen((saved) { 
      if(saved != null && saved == true && context != null ){
        Fluttertoast.showToast(msg: "Vendor Saved" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColors.lightblue,
        textColor: Colors.white,
        fontSize: 16.0, 
        );

        Navigator.of(context).pop();
      } 
    });
    super.initState();
  }

  @override
  void dispose() {
    _saveSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vendorBloc = Provider.of<VendorBloc>(context);
    var authBloc = Provider.of<AuthBloc>(context);

    return StreamBuilder<Vendor>( 
      stream: vendorBloc.vendor,
      builder: (context, snapshot ){
        if(!snapshot.hasData && widget.vendorId != null ){
          return Scaffold(
            body: Center(child: (Platform.isIOS) 
            ? CupertinoActivityIndicator()
            : CircularProgressIndicator(),),
          );
        }
     
      Vendor vendor = snapshot.data;

      if(vendor != null){
        //Edit Logic
        loadValus(vendorBloc, vendor, authBloc.userId);
      }else{
        // Addind Logic
        loadValus(vendorBloc, null, authBloc.userId);
      }

    return (Platform.isIOS) 
      ? AppSliverScafflod.cupertinoPageScaffold(
          navTitle: '',
          pageBody: pageBody(true, vendorBloc, context, vendor),
          context: context)
          : AppSliverScafflod.materialScaffold(
          navTitle: '',
          pageBody: pageBody(false, vendorBloc, context, vendor),
          context: context);
       

      });

      
  }

  Widget pageBody(bool isIOS, VendorBloc vendorBloc, BuildContext context, 
  Vendor existingVendor) {
    var pageLabel = (existingVendor != null) ? 'Edit Profile' : 'Add Profile';
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
            stream: vendorBloc.name,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Product Name',
                cupertinoIcon: FontAwesomeIcons.shoppingBasket,
                materialIcon: FontAwesomeIcons.shoppingBasket,
                errorText: snapshot.error,
                initialText: (existingVendor != null)
                ? existingVendor.name
                : null ,
                onChanged: vendorBloc.changeName,
              );
            }),

            StreamBuilder<String>(
            stream: vendorBloc.description,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: isIOS,
                hintText: 'Description',
                cupertinoIcon: FontAwesomeIcons.shoppingBasket,
                materialIcon: FontAwesomeIcons.shoppingBasket,
                errorText: snapshot.error,
                initialText: (existingVendor != null)
                ? existingVendor.description
                : null ,
                onChanged: vendorBloc.changeDescription,
              );
            }),
         StreamBuilder<bool>(
          stream: vendorBloc.isUploading,
          builder: (context, snapshot) {  
            return (!snapshot.hasData || snapshot.data == false)
            ? Container()
            : Center(child: (Platform.isIOS) 
            ? CupertinoActivityIndicator() : CircularProgressIndicator(),);
          },), 
        StreamBuilder<String>(
          stream: vendorBloc.imageUrl,
          builder: (context, snapshot) {
            if(!snapshot.hasData || snapshot.data == "")
            return AppButton(buttonType: ButtonType.Straw,buttonText: 'Add Image',onPressed: vendorBloc.pickImage,);

            return Column(children: <Widget>[
                Padding(
                  padding: BaseStyles.listPadding,
                  child: Image.network(snapshot.data),
                ),
              AppButton(buttonType: ButtonType.Straw,buttonText: 'Change Image',onPressed: vendorBloc.pickImage,),
            ]);
          }
        ),
        StreamBuilder<Object>(
          stream: vendorBloc.isValid,
          builder: (context, snapshot) {
            return AppButton( 
              buttonType: (snapshot.data == true) ? ButtonType.DarkBlue : ButtonType.Disabled, 
              buttonText: 'Save Profile', 
              onPressed: vendorBloc.saveVendor,
              );
          }
        )
      ],
  

    );
    
  }

  loadValus(VendorBloc vendorBloc, Vendor vendor, String vendorId){
      vendorBloc.changeVendorId(vendorId);

    if(vendor != null){
      // Edit
      vendorBloc.changeName(vendor.name);
      vendorBloc.changeDescription(vendor.description);
      vendorBloc.changeImageUrl(vendor.imageUrl ?? "");
    }else{
      //Add
      vendorBloc.changeName(null);
      vendorBloc.changeDescription(null);
      vendorBloc.changeImageUrl('');
    }
  }

}