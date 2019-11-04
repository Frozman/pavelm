import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Storage {
  // стандартная конструкция синглтона для того, чтобы
  // мы всегда имели единую точку входа и доступа к нашим данным
  // через единственный экземляр
  static final Storage _singleton = Storage._internal();
  factory Storage() {
    return _singleton;
  }
  Storage._internal();

  List<UserData> users = List();

  ValueNotifier<FirebaseUser> _user = ValueNotifier<FirebaseUser>(null);
  FirebaseUser get  user => _user.value;
  set user(FirebaseUser v) {
    _user.value = v;
    _user.notifyListeners();
  }

  userBind(void Function() f) {
    _user.addListener(f);
  }

  userUnbind(void Function() f) {
    _user.removeListener(f);
  }
}

// Создаем класс-контейнер для данных
class UserData {
  String firebaseKey;
  String id;
  List<Map<String, int>> counter;
  String lastName;
  String photoUrl;

  UserData(
      {this.id, this.counter, this.lastName, this.photoUrl, this.firebaseKey});
  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data['lastname'] = lastName;
    data['photo'] = photoUrl;
    data['counter'] = counter;
    data['id'] = id;
    return data;
  }
}
