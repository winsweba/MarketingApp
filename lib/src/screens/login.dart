import 'package:MarketingApp/src/blocs/auth_bloc.dart';
import 'package:MarketingApp/src/styles/base.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:MarketingApp/src/widgets/button.dart';
import 'package:MarketingApp/src/widgets/social_button.dart';
import 'package:MarketingApp/src/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  @override
  void initState() {
    final authBloc = Provider.of<AuthBloc>(context, listen: false);
    authBloc.user.listen((user) {
      if(user != null ) Navigator.pushReplacementNamed(context, '/landing');
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final authBloc = Provider.of<AuthBloc>(context);

    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context, authBloc),
      );
    } else {
      return Scaffold(
        body: pageBody(context, authBloc),
      );
    }
  }

  Widget pageBody(BuildContext context, AuthBloc authBloc) {
    return ListView(
      padding: EdgeInsets.all(0.0),
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/top_bg.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/images/logo.png'))),
        ),
        StreamBuilder<String>(
            stream: authBloc.email,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Email',
                materialIcon: Icons.email,
                cupertinoIcon: CupertinoIcons.mail_solid,
                textInputType: TextInputType.emailAddress,
                errorText: snapshot.error,
                onChanged: authBloc.changeEmail,
              );
            }),
        StreamBuilder<String>(
            stream: authBloc.password,
            builder: (context, snapshot) {
              return AppTextField(
                isIOS: Platform.isIOS,
                hintText: 'Password',
                materialIcon: Icons.lock,
                cupertinoIcon: IconData(
                  0xf4c9,
                  fontFamily: CupertinoIcons.iconFont,
                  fontPackage: CupertinoIcons.iconFontPackage,
                ),
                obscureText: true,
                errorText: snapshot.error,
                onChanged: authBloc.changePassword,
              );
            }),
        StreamBuilder<bool>(
            stream: authBloc.isValid,
            builder: (context, snapshot) {
              return AppButton(
                buttonText: 'Login',
                buttonType: (snapshot.data == true)
                    ? ButtonType.LightBlue
                    : ButtonType.Disabled,
                    onPressed: authBloc.loginEmail,
              );
            }),
        SizedBox(height: 6.0),
        Center(
          child: Text(
            "Or",
            style: TextStyles.suggestions,
          ),
        ),
        SizedBox(height: 6.0),
        Padding(
          padding: BaseStyles.listPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AppSocialButton(
                socialType: SocialType.Facebooke,
              ),
              SizedBox(height: 18.0),
              AppSocialButton(
                socialType: SocialType.Google,
              ),
            ],
          ),
        ),
        Padding(
          padding: BaseStyles.listPadding,
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Already Have an Account',
              style: TextStyles.body,
              children: [
                TextSpan(
                  text: 'SignUp',
                  style: TextStyles.link,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(
                          context,
                          '/signup',
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
