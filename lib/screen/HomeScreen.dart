import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';
import 'package:pavelm/widget/DrawerMenu.dart';
import 'package:pavelm/widget/UserTile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerMenu(),
      body: ListView(
          children: List.generate(Storage().users.length, (index) {
        return UserTile(user: Storage().users[index]);
      })),
    );
  }
}
