import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListReminder with ChangeNotifier {
  final String id;
  String nameList;
  Color color;

  ListReminder(
    this.id,
    this.nameList,
    this.color,
  );
}
