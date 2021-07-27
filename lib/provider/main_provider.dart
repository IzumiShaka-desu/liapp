import 'dart:io';

import 'package:flutter/material.dart';
import 'package:liapp/consts/dummies.dart';
import 'package:liapp/model/profile.dart';
import 'package:liapp/model/task.dart';

class MainProvider extends ChangeNotifier {
  List<Task> myTask = tasks;
  List<ProfileModel> users = dummyUsers;
  ProfileModel currentUser;
  File photoProfile;
  addTask(Task task) {
    
    notifyListeners();
  }
refresh(){
  notifyListeners();
}
  MainProvider({this.currentUser});
  register(ProfileModel user) {
    users.add(user);
    notifyListeners();
  }

  ProfileModel login(String email, String password) {
    var result = users
        .where(
            (element) => element.email == email && element.password == password)
        .toList();
    return result?.first;
  }
}
