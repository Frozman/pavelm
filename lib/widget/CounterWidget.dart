import 'package:flutter/material.dart';

class CounterWidget extends StatefulWidget {
  final ValueNotifier<int> controller;
  // Принимаем обязательный аргумент контроллера
  const CounterWidget({Key key, @required this.controller}) : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  void initState() {
    super.initState();
    // Добавляем слушателя при создании виджета
    widget.controller.addListener(update);
  }

  @override
  void dispose() {
    // Удаляем слушателя при удалении виджета
    widget.controller.removeListener(update);
    super.dispose();
  }

  increment() {
    widget.controller.value++;
    widget.controller.notifyListeners();
  }

  decrement() {
    widget.controller.value--;
    widget.controller.notifyListeners();
  }

  update() {
    // Слушатель изменения значения, запускает перерисовкую
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(border: Border.all(width: 1)),
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text("+"),
            onPressed: increment,
          ),
          Text(
            widget.controller.value.toString(),
          ),
          FlatButton(
            child: Text("+"),
            onPressed: decrement,
          ),
        ],
      ),
    );
  }
}
