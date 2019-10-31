import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';
import 'package:pavelm/widget/CounterWidget.dart';

class UserCounterForm extends StatefulWidget {
  // Получаем сверху пользователя для которого делаем форму
  final UserData user;

  const UserCounterForm({Key key, this.user}) : super(key: key);
  @override
  _UserCounterFormState createState() => _UserCounterFormState();
}

class _UserCounterFormState extends State<UserCounterForm> {
  // Заводим контроллеры значений
  Map<String, ValueNotifier<int>> counterValues = {
    'a': ValueNotifier<int>(0),
    'b': ValueNotifier<int>(0),
    'c': ValueNotifier<int>(0),
  };
  @override
  void initState() {
    super.initState();
    // Говорим значения контроллеров
    prepareValues();
  }

  prepareValues() {
    if (widget.user.counter.length > 0) {
      // Наполняем наши контроллеры значениями из модели
      counterValues['a'].value = widget.user.counter.last['a'];
      counterValues['b'].value = widget.user.counter.last['b'];
      counterValues['c'].value = widget.user.counter.last['c'];
    }
  }

  onSubmit() {
    // По нажатию перебираем контроллеры и меняем модель
    counterValues.forEach((k, v) {
      int lastIndex = widget.user.counter.length - 1;
      counterValues.forEach((k, v) {
        widget.user.counter[lastIndex][k] = v.value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.user.lastName),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  counterValues.values.length,
                  (i) => CounterWidget(
                        controller: counterValues.values.elementAt(i),
                      )),
            ),
          ),
          FlatButton(
            color: Colors.cyan,
            child: Text('submit'),
            onPressed: onSubmit,
          )
        ],
      ),
    );
  }
}

