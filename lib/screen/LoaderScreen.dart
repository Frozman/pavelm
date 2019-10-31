import 'dart:convert';

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
    // Эмулируем загрузку данных
    // Для того, чтобы воспользоваться асинхронной конструкцией then делаем функцию асинхронной ключевым словом async

    String rawData =
        '{"data":{"user":[{"id":"1","counter":[{"a":1,"b":5,"c":7}],"lastName":"Cruise","photo":"https://jsonformatter.org/img/tom-cruise.jpg"},{"id":"2","counter":[{"a":3,"b":1,"c":9}],"lastName":"Sharapova","photo":"https://jsonformatter.org/img/Maria-Sharapova.jpg"},{"id":"3","counter":[{"a":6,"b":2,"c":1}],"firstName":"Robert","lastName":"Downey Jr.","photo":"https://jsonformatter.org/img/Robert-Downey-Jr.jpg"}]}}';
    var data = jsonDecode(rawData);
    // проверяем наличие нужных нам полей чтобы не получить неприятных ошибок
    // жонглирование массивами и map для того чтобы замапить данные на объекты


    
    if (data['data'] != null && data['data']['user'] != null) {
      if (data['data']['user'].runtimeType == List<dynamic>().runtimeType) {
        Storage().users = List.generate(data['data']['user'].length, (i) {
          return UserData(
            id: data['data']['user'][i]['id'],
            counter: List.generate(
                data['data']['user'][i]['counter'].length,
                (j) => Map<String, int>.from(
                    data['data']['user'][i]['counter'][j])),
            lastName: data['data']['user'][i]['lastName'],
            photoUrl: data['data']['user'][i]['photo'],
          );
        });
      }
    }
    // Эмулируем задержку
    await Future.delayed(Duration(seconds: 5));
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
