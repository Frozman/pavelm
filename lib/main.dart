import 'package:flutter/material.dart';
import 'package:pavelm/screen/HistoryScreen.dart';
import 'package:pavelm/screen/HomeScreen.dart';
import 'package:pavelm/screen/LoaderScreen.dart';
import 'package:pavelm/screen/ProfileScreen.dart';

void main() => runApp(PmApp());

// NB! Не используйте в route строку '/home'
// Оно зарезервировано и во избежании различных конфликтов просто избегайте этого слова

class PmApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Объявляем начальным экраном наш лоадер
      initialRoute: "/loader/",
      // Объявляем именованные экраны
      routes: {
        "/loader/": (BuildContext context) => LoaderScreen(),
        "/list/": (BuildContext context) => HomeScreen(),
        "/profile/": (BuildContext context) => ProfileScreen(),
        "/history/": (BuildContext context) => HistoryScreen(),
      },
    );
  }
}
