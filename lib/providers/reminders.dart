import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './list_Reminder.dart';
import './reminder.dart';

class Reminders with ChangeNotifier {
  final List<ListReminder> _itemsList = [
    ListReminder('lr1', 'Nhắc nhở', Colors.blue),
    ListReminder('lr2', 'Tạm', Colors.red),
  ];

  List<ListReminder> get itemsList {
    return [..._itemsList];
  }

  final List<Reminder> _reminderList = [
    Reminder(
      id: 'rl1',
      idList: 'lr1',
      title: 'Title 1',
      dateTime: DateTime.now(),
    ),
    Reminder(
      id: 'rl2',
      idList: 'lr2',
      title: 'title2',
      // dateTime: DateTime.parse('10/20/2022'),
      dateTime: DateTime.utc(2022, 10, 20),
    ),
  ];

  // List<Reminder> get reminderList {
  //   return [..._reminderList];
  // }
  get reminderList => _reminderList;

  //Today
  DateTime getDateTimeId(String id) {
    return _reminderList.firstWhere((rL) => rL.id == id).dateTime;
  }

  int _selectListIndexTemp = -1;

  get selectListIndexTemp => _selectListIndexTemp;

  void changeSelectListIndexTemp(int index) {
    _selectListIndexTemp = index;
    notifyListeners();
  }

  int getIndexListId(String id) {
    return _itemsList.indexWhere((element) => element.id == id);
  }

  // name list
  String getnameList(String idList) {
    return _itemsList
        .firstWhere((element) => element.id == idList)
        .nameList
        .toString();
  }

  Reminder getReminder(String idList, int index) {
    return _reminderList[index];
  }

  String getTitle(String idReminder) {
    return _reminderList
        .firstWhere((element) => element.id == idReminder)
        .title;
  }

  //add reminder
  void addReminder(String input) {
    if (input.isEmpty) input = "Lời nhắc mới";

    Reminder temp = Reminder(
      id: DateTime.now().toString(),
      idList: _itemsList[0].id,
      title: input,
      dateTime: DateTime.now(),
    );

    _reminderList.add(temp);
    notifyListeners();
  }

  //remove reminder
  void removeReminder(String id) {
    _reminderList.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void changePropertyReminder(
    String idReminder,
    String idList,
    String title,
    DateTime dateTime,
  ) {
    final indexList = _itemsList.indexWhere((element) => element.id == idList);
    final iReminder =
        _reminderList.indexWhere((element) => element.id == idReminder);
    // if (indexList == -1 || iReminder == -1) return;
    if (title.isEmpty) {
      title = _reminderList[iReminder].title;
    }
    if (dateTime.toString().isEmpty) {
      dateTime = _reminderList[iReminder].dateTime;
    }
    // if (_selectListIndexTemp == -1 || _selectListIndexTemp == indexList) {
    _reminderList[iReminder].title = title;
    _reminderList[iReminder].dateTime = dateTime;
    //change ID List in Reminder
    if (_selectListIndexTemp >= 0) {
      _reminderList[iReminder].idList = _itemsList[_selectListIndexTemp].id;
    }
    notifyListeners();
    // return;
    // }
  }

  // tentaviveSchedule all
  List<TentativeSchedule> get tentaviveSchedule_item {
    final tempLR = _reminderList;
    tempLR.sort((a, b) {
      var adate = a.dateTime; //before -> var adate = a.expiry;
      var bdate = b.dateTime; //var bdate = b.expiry;
      return adate.compareTo(bdate);
    });
    List<TentativeSchedule> tempTen = [];
    List<Reminder> tempR = [];
    for (int i = 0; i < tempLR.length; i++) {
      if (i != tempLR.length - 1) {
        tempR.add(tempLR[i]);
        if (tempLR[i].dateTime.year.toString() !=
                tempLR[i + 1].dateTime.year.toString() ||
            tempLR[i].dateTime.month.toString() !=
                tempLR[i + 1].dateTime.month.toString() ||
            tempLR[i].dateTime.day.toString() !=
                tempLR[i + 1].dateTime.day.toString())
        // if (tempLR[i].dateTime != tempLR[i + 1].dateTime)
        {
          tempTen.add(TentativeSchedule(tempLR[i].dateTime, tempR));
          tempR = [];
        }
        // else {
        //   tempR.add(tempLR[i + 1]);
        //   tempTen.add(TentativeSchedule(tempLR[i].dateTime, tempR));
        // }
      } else {
        if (tempLR[i].dateTime.year.toString() ==
                tempLR[i - 1].dateTime.year.toString() &&
            tempLR[i].dateTime.month.toString() ==
                tempLR[i - 1].dateTime.month.toString() &&
            tempLR[i].dateTime.day.toString() ==
                tempLR[i - 1].dateTime.day.toString()) {
          tempR.add(tempLR[i]);
          tempTen.add(TentativeSchedule(tempLR[i].dateTime, tempR));
        } else {
          tempR = [];
          tempR.add(tempLR[i]);
          tempTen.add(TentativeSchedule(tempLR[i].dateTime, tempR));
        }
      }
    }
    return [...tempTen];
  }

  void tempprint() {
    _reminderList.sort((a, b) {
      var adate = a.dateTime; //before -> var adate = a.expiry;
      var bdate = b.dateTime; //var bdate = b.expiry;
      return adate.compareTo(bdate);
    });
    for (int i = 0; i < _reminderList.length; i++) {
      print(_reminderList[i].dateTime.toString());
    }
  }
}

class TentativeSchedule with ChangeNotifier {
  DateTime dateTime;
  List<Reminder> tenlistreminder;

  TentativeSchedule(
    this.dateTime,
    this.tenlistreminder,
  );
}
