import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:reminder_app/providers/list_Reminder.dart';

import '../providers/reminders.dart';

class NewReminder extends StatefulWidget {
  final String idReminder;
  final String idListReminder;
  NewReminder(
    this.idReminder,
    this.idListReminder,
  );

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  TextEditingController controller = TextEditingController();

  late DateTime selectDateTime;

  bool checkPicked = false;

  bool checkSelectList = false;

  bool check1(int a, int b, int index1) {
    if (checkSelectList == false) {
      if (a == b) {
        return true;
      } else {
        return false;
      }
    } else {
      if (b == index1) return true;
    }
    return false;
  }

  void datePicked(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime(2022),
      firstDate: DateTime(2020),
      lastDate: DateTime(2024),
    ).then((datePicked) {
      if (datePicked == null) return;
      selectDateTime = datePicked;
      setState(() {
        checkPicked == false ? checkPicked = true : checkPicked = true;
      });
    });
  }

  void showmodalBottom(BuildContext context, List<ListReminder> listReminder) {
    showBottomSheet(
        context: context,
        builder: (_) {
          return ListView.builder(
              itemCount: listReminder.length,
              itemBuilder: (ctx, index) => ListTile(
                    title: Text(listReminder[index].nameList),
                  ));
        });
  }

  @override
  Widget build(BuildContext context) {
    final productsdata = Provider.of<Reminders>(context);
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: const Text("Hủy", style: TextStyle(color: Colors.blue)),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              const Text("Chi tiết",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              InkWell(
                child: const Text("Xong", style: TextStyle(color: Colors.blue)),
                onTap: () {
                  if (!checkPicked) {
                    selectDateTime =
                        productsdata.getDateTimeId(widget.idReminder);
                  }
                  productsdata.changePropertyReminder(
                    widget.idReminder,
                    widget.idListReminder,
                    controller.text,
                    selectDateTime,
                  );
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    // height: 30,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    color: Colors.black12,
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: productsdata.getTitle(widget.idReminder),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        datePicked(context);
                      },
                      icon: const Icon(
                        Icons.calendar_month,
                        color: Colors.red,
                      ),
                    ),
                    checkPicked
                        ? Text(
                            DateFormat.yMd().format(selectDateTime).toString())
                        : const Text("select date!"),
                    const SizedBox(),
                  ],
                ),
                const Text("Danh sách:"),
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    itemCount: productsdata.itemsList.length,
                    itemBuilder: (ctx, index) => ListTile(
                      onTap: () {
                        setState(() {
                          checkSelectList = true;
                        });
                        productsdata.changeSelectListIndexTemp(index);
                        // productsdata.tempItemsToday();
                      },
                      title: Text(
                        productsdata.itemsList[index].nameList,
                      ),
                      trailing: check1(
                              productsdata
                                  .getIndexListId(widget.idListReminder),
                              index,
                              productsdata.selectListIndexTemp)
                          // productsdata.getIndexListId(idListReminder) == index
                          ? const Icon(Icons.check)
                          : const Text(''),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
