import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../widgets/new_reminder.dart';

import '../providers/reminders.dart';

class ReminderTodayCreen extends StatefulWidget {
  static const routeName = '/reminder-today';

  @override
  State<ReminderTodayCreen> createState() => _ReminderTodayCreenState();
}

class _ReminderTodayCreenState extends State<ReminderTodayCreen> {
  TextEditingController controller = TextEditingController();

  void _startNewReminder(
    BuildContext ctx,
    String id,
    String idListReminder,
  ) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {
              print(id);
            },
            child: NewReminder(id, idListReminder),
          );
        });
  }

  showAlertDialog(BuildContext context, String id, String content) {
    final data = Provider.of<Reminders>(context, listen: false);
    // Create button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        data.removeReminder(id);
        Navigator.of(context).pop();
      },
    );
    Widget cancel = TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'));

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Notification"),
      content: Text("Are you sure delete \" ${content.toString()} \"?"),
      actions: [
        okButton,
        cancel,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Reminders>(context);
    final listReminder = data.itemsList;
    final reminderList = data.reminderList;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 30,
        // automaticallyImplyLeading: false,
        // backgroundColor: Colors.black38,
        // leading: const Text('Danh sách'),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.white,
        title: const Center(
            child: Text(
          'Hôm nay',
          style: TextStyle(
            color: Colors.blue,
          ),
        )),
        actions: const [
          Icon(Icons.edit),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Hôm nay',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                    ),
                    listReminder.isEmpty
                        ? const Text('khoong co')
                        : Column(
                            children: List.generate(
                              reminderList.length,
                              (index) => ListTile(
                                leading: IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  iconSize: 20,
                                  onPressed: () {
                                    // data.removeReminder(reminderList[index].id);
                                    showAlertDialog(
                                        context,
                                        reminderList[index].id,
                                        reminderList[index].title);
                                  },
                                ),
                                title: Text(reminderList[index].title),
                                subtitle: Row(
                                  children: [
                                    Text(data.getnameList(
                                        reminderList[index].idList)),
                                    Text(
                                        '- ${DateFormat.yMd().format(reminderList[index].dateTime).toString()}'),
                                  ],
                                ),
                                trailing: IconButton(
                                  onPressed: () {
                                    _startNewReminder(
                                        context,
                                        reminderList[index].id,
                                        reminderList[index].idList);
                                  },
                                  icon: const Icon(Icons.notes),
                                ),
                              ),
                            ),
                          ),
                    TextField(
                      controller: controller,
                      decoration: const InputDecoration(
                        hintText: 'Lời nhắc mới!',
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            TextButton(
                onPressed: () {
                  data.addReminder(controller.text.toString());
                  controller.text = '';
                },
                child: Row(
                  children: const [
                    Icon(Icons.add_circle_outline),
                    SizedBox(width: 5),
                    Text('Thêm Lời nhắc mới'),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
