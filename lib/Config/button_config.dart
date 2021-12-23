import 'package:flutter/material.dart';
import 'package:school_management/Config/color_config.dart';

class ButtonConfig extends StatelessWidget {
  
  var text, press;
  ButtonConfig({this.text, this.press});
  
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      minWidth: MediaQuery.of(context).size.width,
        color: colors,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        onPressed: press, 
        child: Text(text,style: buttonStyle,)
    );
  }
}
