import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';

// Этот экран нужен для того, чтобы как можно быстрее получить контроль над приложением
// Во время runApp мы не выполняем ничего тяжелого. Всю загрузку данных мы проводим на этом экране
// После всего переходим на экран start
class LoaderScreen extends StatefulWidget {
  @override
  _LoaderScreenState createState() => _LoaderScreenState();
}

class _LoaderScreenState extends State<LoaderScreen> {
  @override
  void initState() {
    super.initState();
    // doLoad - действия по загрузке данных
    doLoad().then(onLoad);
    // По окочании задержки выполняем функцию onLoad
  }

  doLoad() async {
    // Загружаем данные
    // Создаем инстанс 
    // Firestore
    QuerySnapshot firedata =
        await Firestore.instance.collection('users').getDocuments(source: Source.server);

    // Создаем список пользователей согласно firebase документам
    Storage().users = List.generate(firedata.documents.length, (i){
      // Вводим переменную для конкретного документа
      var doc = firedata.documents[i].data;

      // Вводим переменную для ключа конктерного документа 
      var key = firedata.documents[i].documentID;


      // Создаем инстанс данных пользователя
      return UserData(
        firebaseKey: key,
         id: doc['id'].toString(),
        counter: List.generate(
            doc['counter'].length,
            (j) =>
                Map<String, int>.from(doc['counter'][j])),
        lastName: doc['lastname'],
        photoUrl: doc['photo'], 
      );
    });

  
    return true;
  }

  onLoad(emptyValue) {
    // Переходим на главный экран
    Navigator.of(context).pushReplacementNamed('/home/');
  }

  @override
  Widget build(BuildContext context) {
    // Создаем простой интерфейс загрузки
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
