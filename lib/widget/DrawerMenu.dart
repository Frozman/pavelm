import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          DrawerHeader(
            child: Container(),
          ),
          FlatButton.icon(
              label: Text("Счетчики"),
              icon: Icon(Icons.list),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/list/");
              }),
          FlatButton.icon(
              label: Text("Профиль"),
              icon: Icon(Icons.account_box),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/profile/");
              }),
              FlatButton.icon(
              label: Text("История"),
              icon: Icon(Icons.history),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/history/");
              })
        ]),
      ),
    );
  }
}
