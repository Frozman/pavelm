import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';
import 'package:pavelm/screen/UserDetailScreen.dart';

class UserTile extends StatefulWidget {
  final UserData user;
  const UserTile({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  _UserTileState createState() => _UserTileState();
}

class _UserTileState extends State<UserTile> {
  @override
  Widget build(BuildContext context) {
    onTap() {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (ctx) => UserDetailScreen(
                user: widget.user,
              )));
    }

    return ListTile(
        onTap: onTap,
        title: Text(widget.user.lastName),
        trailing: Icon(Icons.chevron_right));
  }
}
