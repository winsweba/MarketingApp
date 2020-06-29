import 'package:MarketingApp/src/styles/base.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:MarketingApp/src/widgets/button.dart';
import 'package:MarketingApp/src/widgets/social_button.dart';
import 'package:MarketingApp/src/widgets/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoPageScaffold(
        child: pageBody(context),
      );
    } else {
      return Scaffold(
        body: pageBody(context),
      );
    }
  }

  Widget pageBody(BuildContext context) {
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
        AppTextField(
          isIOS: Platform.isIOS,
          hintText: 'Email',
          materialIcon: Icons.email,
          cupertinoIcon: CupertinoIcons.mail_solid,
          textInputType: TextInputType.emailAddress,
        ),
        AppTextField(
          isIOS: Platform.isIOS,
          hintText: 'Password',
          materialIcon: Icons.lock,
          cupertinoIcon: IconData(
            0xf4c9,
            fontFamily: CupertinoIcons.iconFont,
            fontPackage: CupertinoIcons.iconFontPackage,
          ),
          obscureText: true,
        ),
        AppButton(
          buttonText: 'Signup',
          buttonType: ButtonType.LightBlue,
        ),
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
              SizedBox(height: 15.0),
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
                  text: 'Login',
                  style: TextStyles.link,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => Navigator.pushNamed(
                          context,
                          '/login',
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
