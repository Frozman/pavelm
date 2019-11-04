import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';
import 'package:pavelm/widget/DrawerMenu.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pavelm/widget/UserProfileWidget.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerMenu(),
      body: ProfileScreenBody(),
    );
  }
}

class ProfileScreenBody extends StatefulWidget {
  @override
  _ProfileScreenBodyState createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  // Получаем в пользование инстанс, объявляем финальным, чтобы мы не могли повторно присвоить значение
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    // Подписываемся на событие через метод обертку
    Storage().userBind(update);
  }

  @override
  void dispose() {
    // Отписываемся через метод обертку
    Storage().userUnbind(update);
    super.dispose();
  }

  // Метод слушатель событий, который вызывает перерисовку, когда меняется значение
  update() {
    setState(() {});
  }

  // Обработчик нажатия на авторизацию
  onAuthPress() async {
    // google_sign_in плагин. Создаем конфигурацию для методов авторизации
    final GoogleSignIn _googleSignIn = GoogleSignIn();

    // Вызываем авторизацию со стороны устройства через нативные api проброшенные в dart
    // await тут нужен т.к. обе операции (метод и геттер) возвращают не значения, а Future.
    // Для того, чтобы функция выполнилась синхронно в этих шагах стоит await.
    // Если функция возвращает Future и перед ней стоит await - процесс выполнения этого изолята (потока)
    // будет приостановлен, пока не придет значение и Future не будет выполнен
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    Storage().user = (
            // Запускаем процесс авторизации на сервере, передаем в качестве доступов credentials
            await _auth.signInWithCredential(
                // Для получения credentials нам нужны локальные access и id
                // Их мы получаем на устройстве с помощью .signIn() и .authentication
                GoogleAuthProvider.getCredential(
                    accessToken: googleAuth.accessToken,
                    idToken: googleAuth.idToken)))
        // Из всех данных нам нужен только пользователь
        .user;
  }

  // Функция которая готовит виджеты кнопок.
  // Метод виджета который возвращает виджет - антипаттерн ( по хорошему)
  // Но позволяет избежать проброса обработчиков и данные
  // Не особо влияет на производительность
  
  Widget buildAuthButtons() {
    return Storage().user == null
        ? Row(
            children: <Widget>[
              RaisedButton(
                child: Text('GOOGLE AUTH'),
                onPressed: onAuthPress,
              )
            ],
          )
        : Container();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        UserProfileWidget(
          user: Storage().user,
        ),
        buildAuthButtons()
      ],
    );
  }
}
