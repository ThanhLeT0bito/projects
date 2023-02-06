import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Reminder with ChangeNotifier {
  final String id;
  String idList;
  String title;
  DateTime dateTime;
  Reminder({
    required this.id,
    required this.idList,
    required this.title,
    required this.dateTime,
  });
}
