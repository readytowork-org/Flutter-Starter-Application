import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final void Function() onTap;
  final Color buttonColor;
  final String buttonText;
  final double? fontSize;
  final Color? fontColor;
  final double? height;
  final double? minWidth;
  final bool? loading;

  const ButtonComponent({
    Key? key,
    required this.onTap,
    required this.buttonColor,
    required this.buttonText,
    this.fontSize,
    this.fontColor,
    this.height,
    this.minWidth,
    this.loading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loadingValue = loading ?? false;

    return InkWell(
      splashColor: Colors.white24,
      child: loadingValue
          ? const Padding(
              padding: EdgeInsets.all(10.0),
              child: CupertinoActivityIndicator(),
            )
          : MaterialButton(
              height: height,
              minWidth: minWidth,
              color: buttonColor,
              child: Text(
                buttonText,
                style: TextStyle(fontSize: fontSize, color: fontColor),
              ),
              onPressed: onTap),
    );
  }
}
