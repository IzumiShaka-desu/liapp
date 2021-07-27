import 'package:flutter/material.dart';

class TaskProgress extends StatelessWidget {
  final Color color;
  final double val;
  final double max;

  const TaskProgress(
      {Key key, this.color = Colors.blue, this.val = 0, this.max = 100})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        thumbShape: SliderComponentShape.noThumb,
      ),
      child: Slider(
          value: val,
          focusNode: FocusNode(),
          activeColor: color,
          inactiveColor: color.withOpacity(0.3),
          onChanged: (val) {},
          max: max),
    );
  }
}
