import 'package:flutter/material.dart';
import 'package:liapp/consts/color_palette.dart';

class CircleCheckBox extends StatelessWidget {
  final bool isChecked;
  final Color color;

  const CircleCheckBox(
      {Key key, this.isChecked = false, this.color = ColorPalette.altBlue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      child: Container(
        decoration: BoxDecoration(
          color: isChecked? color.withOpacity(0.5):ColorPalette.mainWhite,
          border: Border.all(color:isChecked?color.withOpacity(0.1):color,width: 2,),
          shape: BoxShape.circle,
        ),
        child: isChecked
            ? Icon(
                Icons.check,
                color:ColorPalette.mainWhite,
              )
            : Icon(
                Icons.circle,
                color: Colors.transparent,
              ),
      ),
    );
  }
}
