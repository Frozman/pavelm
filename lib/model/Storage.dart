import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pavelm/model/HistoryModel.dart';
import 'package:pavelm/model/UserData.dart';

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

  HistoryStorage historyStorage = HistoryStorage();

  ValueNotifier<FirebaseUser> _user = ValueNotifier<FirebaseUser>(null);

  // Методы обертки, просто для удобства и лаконичности 
  FirebaseUser get user => _user.value;
  set user(FirebaseUser v) {
    _user.value = v;
    _user.notifyListeners();
  }
  
  userBind(void Function() f) => _user.addListener(f);
  userUnbind(void Function() f) => _user.removeListener(f);
}


