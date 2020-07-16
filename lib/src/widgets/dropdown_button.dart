import 'package:MarketingApp/src/styles/base.dart';
import 'package:MarketingApp/src/styles/buttons.dart';
import 'package:MarketingApp/src/styles/colors.dart';
import 'package:MarketingApp/src/styles/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AppDropdownButton extends StatelessWidget {
  final List<String> items;
  final String hintText;
  final IconData materialIcon;
  final IconData cupertinoIcon;
  final String value;
  final Function(String) onChanged;

  AppDropdownButton(
      {@required this.items,
      @required this.hintText,
      this.materialIcon,
      this.cupertinoIcon,
      this.value,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return Padding(
        padding: BaseStyles.listPadding,
        child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
            border: Border.all(
                color: AppColors.straw, width: BaseStyles.borderWidth),
          ),
          child: Row(
            children: <Widget>[
              Container(
                  width: 35.0, child: BaseStyles.iconPrefix(materialIcon)),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    child: (value == null)
                        ? Text(hintText, style: TextStyles.suggestions)
                        : Text(value, style: TextStyles.body),
                    onTap: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (BuildContext contecxt) {
                          return _selectIOS(context, items);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: BaseStyles.listPadding,
        child: Container(
          height: ButtonStyles.buttonHeight,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(BaseStyles.borderRadius),
            border: Border.all(
                color: AppColors.straw, width: BaseStyles.borderWidth),
          ),
          child: Row(
            children: <Widget>[
              Container(
                  width: 35.0, child: BaseStyles.iconPrefix(materialIcon)),
              Expanded(
                child: Center(
                  child: DropdownButton<String>(
                    items: buildMaterialItem(items),
                    value: value,
                    hint: Text(
                      hintText,
                      style: TextStyles.suggestions,
                    ),
                    style: TextStyles.body,
                    underline: Container(),
                    iconEnabledColor: AppColors.straw,
                    onChanged: (value) => onChanged(value),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  List<DropdownMenuItem<String>> buildMaterialItem(List<String> items) {
    return items
        .map(
          (item) => DropdownMenuItem<String>(
            child: Text(
              item,
              textAlign: TextAlign.center,
            ),
            value: item,
          ),
        )
        .toList();
  }

  List<Widget> buildCupertinoItem(List<String> items) {
    return items
        .map(
          (item) => Text(
            item,
            textAlign: TextAlign.center,
            style: TextStyles.picker,
          ),
        )
        .toList();
  }

  _selectIOS(BuildContext context, List<String> items) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
          color: Colors.white,
          height: 200.0,
          child: CupertinoPicker(
            itemExtent: 45.0,
            children: buildCupertinoItem(items),
            diameterRatio: 1.0,
            onSelectedItemChanged: (int index) => onChanged(items[index]),
          )),
    );
  }
}
