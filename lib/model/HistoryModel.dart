import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';

class HistoryStorage {
  List<HistoryItem> items = List();
  
  ValueNotifier<int> controller = ValueNotifier(0);

  // Геттер для сборки всех элементов массива items в нужный нам формат 
  List<Map> get itemsToFirebase =>
      List.generate(items.length, (i) => items[i].toMap());
  // метод добавления в историю
  void append(HistoryItem item) {
    items.add(item);
    // Обновляем данные контроллера
    controller.value = items.length;
    // Уведомляем всех слушателей изменения контроллера
    controller.notifyListeners();
  }

  Future<String> fetch() async {
    String error;
    // Форматируем ошибку
    error = Storage().user == null ? "You not authorized" : null;
    if (error == null) {
      // Получаем данные из базы данные . Документ с ключом uid (соответствует уникальному коду пользователя)
      // из Коллекции history
      var result = await Firestore.instance
          .collection('history')
          .document(Storage().user.uid)
          .get();

      // Отбираем нужные нам данные это поле History 
      List history = result.data['History'];

      items = List.generate(
          history.length,
          (i) => HistoryItem(
                counter: Map<String,int>.from(history[i]['counter']),
                time: history[i]['time'],
              ));
      controller.value = items.length;
      controller.notifyListeners();
    }

    return error;
  }
  // Метод выгрузки данных на сервер
  Future<String> upload() async {
    
    String error;
    // Проверяем на наличие данных , формируем текст ошибки
    error = Storage().user == null ? "You not authorized" : null;
    // Если ошибок нет 
    if (error == null) {
      // Форматируем наши данные с помощью геттера
      Map<String, dynamic> data = {'History': itemsToFirebase};
      // отправляем на сохранение в коллекцию history, где ключ документа - uid пользователя
      // 
       Firestore.instance
          .collection('history')
          .document(Storage().user.uid)
          .setData(data);
    }

    return error;
  }
}
// Тип контейнер для данных с удобным методом для форматирования
class HistoryItem {
  Timestamp time;
  Map<String, int> counter;

  HistoryItem({@required this.time, @required this.counter});
  Map toMap() {
    Map data = Map();
    data['time'] = time;
    data['counter'] = counter;
    return data;
  }
}
