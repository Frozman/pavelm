
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';

class UserProfileWidget extends StatelessWidget {
  final FirebaseUser user;


  onSignout(){
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.signOut();
    Storage().user = null;
  }

  UserProfileWidget({Key key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (user == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            minRadius: 40,
            maxRadius: 40,
            backgroundImage: NetworkImage(user.photoUrl),
          ),
          Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user.displayName.replaceAll(" ", "\n"),
                    style: Theme.of(context).textTheme.headline,
                  ),
                  Text(user.email, style: Theme.of(context).textTheme.subtitle),
                  Text(user.providerId,
                      style: Theme.of(context).textTheme.subtitle)
                ],
              )),
              RaisedButton(
                child: Text("SIGN OUT"),
                onPressed: onSignout,
              )
        ],
      ),
    );
  }
}
