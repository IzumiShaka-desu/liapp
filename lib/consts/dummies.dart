import 'package:liapp/model/profile.dart';
import 'package:liapp/model/task.dart';

var tasks = List<Task>.generate(
  5,
  (index) => Task(
      date: DateTime.now(),
      name: 'try dicoding codelab ${index+1}',
      isDone: index.isOdd,
      type: index == 0 ? TaskType.personal : TaskType.business),
);
var dummyUsers = <ProfileModel>[
  ProfileModel(
      name: "Sesaka Aji Nursyah Bantani",
      email: "shakaaji29@gmail.com",
      password: "123456"),
  ProfileModel(
      name: "keqing wangy", 
      email: "keqingcyan@gmail.com", 
      password: '123456')
];
