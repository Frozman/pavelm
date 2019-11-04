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
  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Storage().userBind(update);
  }

  @override
  void dispose() {
    Storage().userUnbind(update);
    super.dispose();
  }

  update() {
    setState(() {});
  }

  onAuthPress() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    Storage().user = (await _auth.signInWithCredential(
            GoogleAuthProvider.getCredential(
                accessToken: googleAuth.accessToken,
                idToken: googleAuth.idToken)))
        .user;
  }

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
