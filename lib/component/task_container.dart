
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liapp/component/circle_checkbox.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/model/task.dart';
import 'package:liapp/provider/main_provider.dart';

class TaskContainer extends StatelessWidget {
  const TaskContainer({
    Key key,
    @required this.item,
    @required this.isPersonal,
    this.provider,
    this.index, this.trailing,
  }) : super(key: key);

  final Task item;
  final int index;
  final bool isPersonal;
  final MainProvider provider;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    var txtTheme = Theme.of(context).textTheme;
    return Card(
      child: ListTile(
        leading: InkWell(
          onTap: () {
            provider.myTask[index].isDone = !item.isDone;
            provider.refresh();
          },
          child: CircleCheckBox(
            isChecked: item.isDone,
            color: isPersonal ? ColorPalette.altBlue : ColorPalette.pink,
          ),
        ),
        title: Text(
          item.name,
          style: txtTheme.bodyText1.copyWith(
              fontWeight: FontWeight.w500,
              decoration: item.isDone
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              fontSize: 17),
        ),
        trailing: trailing??SizedBox(),
      ),
      color: ColorPalette.mainWhite,
    );
  }
}
