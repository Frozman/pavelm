import 'package:flutter/material.dart';
import 'package:pavelm/model/UserData.dart';
import 'package:pavelm/widget/DrawerMenu.dart';
import 'package:pavelm/widget/UserCounterForm.dart';

class UserDetailScreen extends StatefulWidget {
  final UserData user;

  const UserDetailScreen({Key key, this.user}) : super(key: key);
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerMenu(),
      body: UserCounterForm(
        user: widget.user,
      ),
    );
  }
}
