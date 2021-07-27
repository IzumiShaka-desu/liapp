import 'package:flutter/material.dart';
import 'package:liapp/component/task_container.dart';
import 'package:liapp/component/task_progress.dart';
import 'package:liapp/consts/color_palette.dart';
import 'package:liapp/model/task.dart';
import 'package:liapp/provider/main_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _key = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    var txtTheme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: ColorPalette.secondary,
      body: Container(
        padding: EdgeInsets.all(10),
        child: Consumer<MainProvider>(
          builder: (context, provider, child) {
            var tasks = provider.myTask;
            var businessTaskCount = tasks
                .where((element) => element.type == TaskType.business)
                .length;
            var personalTaskCount = tasks
                .where((element) => element.type == TaskType.personal)
                .length;
            var businessTaskDoneCount = tasks
                .where((element) =>
                    element.type == TaskType.business && element.isDone)
                .length;
            var personalTaskDoneCount = tasks
                .where((element) =>
                    element.type == TaskType.personal && element.isDone)
                .length;
            var user = provider.currentUser;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'What\'s up, ${user.name.split(' ').first}! ',
                    style: txtTheme.headline5.copyWith(
                        fontWeight: FontWeight.w600,
                        color: ColorPalette.mainBlue),
                  ),
                ),
                Container(
                  height: 100,
                  child: Row(
                    children: [
                      Expanded(
                        child: Card(
                          elevation: 2,
                          color: ColorPalette.mainWhite,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$personalTaskCount Tasks',
                                  style: txtTheme.bodyText2
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  'Personal',
                                  style: txtTheme.headline6.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: TaskProgress(
                                    val: personalTaskDoneCount.toDouble(),
                                    max: personalTaskCount.toDouble(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          elevation: 2,
                          color: ColorPalette.mainWhite,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '$businessTaskCount Tasks',
                                  style: txtTheme.bodyText2
                                      .copyWith(color: Colors.grey),
                                ),
                                Text(
                                  'Businness',
                                  style: txtTheme.headline6.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(
                                  child: TaskProgress(
                                    val: businessTaskDoneCount.toDouble(),
                                    max: businessTaskCount.toDouble(),
                                    color: ColorPalette.pink,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Container(
                    child: SingleChildScrollView(
                      child: AnimatedList(
                        shrinkWrap: true,
                        reverse: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8),
                        key: _key,
                        initialItemCount: tasks.length,
                        itemBuilder: (BuildContext context, int index, anim) {
                          Task item = tasks[index];
                          bool isPersonal = item.type == TaskType.personal;
                          return _buildItem(
                              anim, item, provider, index, isPersonal);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showGeneralDialog(
              context: context,
              transitionDuration: Duration(milliseconds: 400),
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                DateTime dateTime = DateTime.now();
                TaskType taskType = TaskType.personal;
                final nameController = TextEditingController();
                return ScaleTransition(
                  scale: animation,
                  child: Material(
                    child: SafeArea(
                      child: StatefulBuilder(
                        builder: (BuildContext context,
                                void Function(void Function()) setState) =>
                            Container(
                          color: ColorPalette.secondary,
                          width: double.infinity,
                          height: double.infinity,
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            8, 5, 8, 5),
                                        child: TextFormField(
                                          controller: nameController,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                              labelText:
                                                  '         Enter New Task ',
                                              border: InputBorder.none),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                DateTime pickedDateTime =
                                                    await showDialog<DateTime>(
                                                  context: context,
                                                  builder: (context) =>
                                                      SimpleDialog(
                                                    title: Text('Select Date'),
                                                    children: [
                                                      Container(
                                                        child:
                                                            CalendarDatePicker(
                                                          initialDate: dateTime,
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate:
                                                              DateTime(2100),
                                                          onDateChanged:
                                                              (DateTime value) {
                                                            Navigator.of(
                                                                    context)
                                                                .pop(value);
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                                setState(() =>
                                                    dateTime = pickedDateTime);
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        8, 5, 8, 5),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                    border: Border.all(
                                                        color: Colors.grey)),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Icon(Icons
                                                        .calendar_today_outlined),
                                                    SizedBox(width: 5),
                                                    Text(dateTime
                                                                .difference(
                                                                    DateTime
                                                                        .now())
                                                                .inDays <
                                                            1
                                                        ? 'Today'
                                                        : dateTime
                                                                    .difference(
                                                                        DateTime
                                                                            .now())
                                                                    .inDays ==
                                                                1
                                                            ? 'Tomorrow'
                                                            : '${dateTime.day}/${dateTime.month}/${dateTime.year}'),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Radio<TaskType>(
                                            groupValue: taskType,
                                            value: TaskType.personal,
                                            onChanged: (value) {
                                              setState(() => taskType = value);
                                            },
                                          ),
                                          Text('Personal'),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Radio<TaskType>(
                                            groupValue: taskType,
                                            value: TaskType.business,
                                            activeColor: ColorPalette.pink,
                                            onChanged: (value) {
                                              setState(() {
                                                setState(
                                                    () => taskType = value);
                                              });
                                            },
                                          ),
                                          Text('business')
                                        ],
                                      ),
                                      SizedBox(
                                        height: 90,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Transform.scale(
                                    scale: 0.7,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.close_outlined,
                                          size: 30,
                                        ),
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      if (nameController.text.isEmpty) {
                                        showSnackbar(
                                            'name task cannot be null');
                                      } else {
                                        var newTask = Task(
                                            date: dateTime,
                                            name: nameController.text,
                                            type: taskType,
                                            isDone: false);
                                        addTask(newTask);
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.fromLTRB(30, 15, 30, 15),
                                      decoration: BoxDecoration(
                                          color: ColorPalette.altBlue,
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Text(
                                        'Save New Task',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            .copyWith(
                                                color: ColorPalette.mainWhite),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
          backgroundColor: ColorPalette.altBlue,
        ),
      ),
    );
  }

  Widget _buildItem(Animation<double> anim, Task item, MainProvider provider,
      int index, bool isPersonal) {
    return ScaleTransition(
      scale: anim,
      child: TaskContainer(
        item: item,
        provider: provider,
        index: index,
        isPersonal: isPersonal,
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => _removeTask(index),
        ),
      ),
    );
  }

  addTask(newTask) {var provider=Provider.of<MainProvider>(context, listen: false);
    provider.myTask.add(newTask);
    
    int index =
        Provider.of<MainProvider>(context, listen: false).myTask.length - 1;
    _key.currentState.insertItem(index);
    provider.refresh();
  }

  showSnackbar(String _msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          backgroundColor: Colors.grey,
          content: Material(
            type: MaterialType.transparency,
            child: Container(
              height: 50,
              child: Center(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _msg,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  _removeTask(int index) {
    var provider = Provider.of<MainProvider>(context, listen: false);
    Task deletedTask = provider.myTask.removeAt(index);
    _key.currentState.removeItem(
      index,
      (context, anim) => _buildItem(anim, deletedTask, provider, index,
          deletedTask.type == TaskType.personal),
    );
    provider.refresh();
  }
}
