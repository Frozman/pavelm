import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pavelm/model/Storage.dart';
import 'package:pavelm/widget/DrawerMenu.dart';

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: DrawerMenu(),
      body: HistoryBody(),
    );
  }
}

class HistoryBody extends StatefulWidget {
  @override
  _HistoryBodyState createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  void initState() {
    super.initState();
    load();
    // Подписываемся на изменения
    Storage().historyStorage.controller.addListener(update);
  }

  @override
  void dispose() {
    // Отписываемся
    Storage().historyStorage.controller.removeListener(update);
    super.dispose();
  }

  update() {
    // Проверяем находится ли в дереве наш виджета, без провервки будут происходить ошибки
    // в случае если виджет уже удален из дерева, но в памяти еще существует.
    if (mounted) {
      setState(() {});
    }
  }

  load() async {
    // Получаем данные
    Storage().historyStorage.fetch().then((error) {
      // Если текст ошибки не пуст - говорим об этом пользователю
      if (error != null) {
        Scaffold.of(context).showSnackBar(SnackBar(
          content: Text(
            error,
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var history = Storage().historyStorage.items;
    return ListView(
        children: List.generate(
      history.length,
      (i) => HistoryItemTile(
        time: history[i].time,
        counter: history[i].counter,
        imageUri: history[i].imageurl,
      ),
    ));
  }
}

class HistoryItemTile extends StatefulWidget {
  final Timestamp time;
  final Map<String, int> counter;
  final String imageUri;

  const HistoryItemTile({Key key, this.time, this.counter, this.imageUri})
      : super(key: key);
  @override
  _HistoryItemTileState createState() => _HistoryItemTileState();
}

class _HistoryItemTileState extends State<HistoryItemTile> {
  String imageLink;

  @override
  void initState() {
    super.initState();
    loadImageUrl();
  }

  loadImageUrl() async {
    if (widget.imageUri != null) {
      FirebaseStorage()
          .ref()
          .child(widget.imageUri)
          .getDownloadURL()
          .then((data) {
        setState(() {
          imageLink = data;
        });
      });
    }
  }

  Widget buildTrailing() {
    print(imageLink);
    if (widget.imageUri == null) {
      return Container(
        width: 1,
      );
    }
    if (imageLink == null) {
      return CircularProgressIndicator();
    }
    return Image.network(
      imageLink,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: buildTrailing(),
      subtitle: Text(widget.time.toDate().toLocal().toIso8601String()),
      title: Text(widget.counter.toString()),
    );
  }
}
