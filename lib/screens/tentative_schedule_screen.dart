import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/reminders.dart';
import '../widgets/new_reminder.dart';

class TentativeScheduleScreen extends StatefulWidget {
  const TentativeScheduleScreen({Key? key}) : super(key: key);
  static const routeName = '/tentative-shedule';

  @override
  State<TentativeScheduleScreen> createState() =>
      _TentativeScheduleScreenState();
}

class _TentativeScheduleScreenState extends State<TentativeScheduleScreen> {
  FocusNode _focus = FocusNode();
  List<FocusNode> _listFocusNode = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    // for (int i=0; i<_listFocusNode.length; i++)
    // _listFocusNode[i].addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    for (int i = 0; i < _listFocusNode.length; i++) {
      _listFocusNode[i].removeListener(_onFocusChange);
      _listFocusNode[i].dispose();
    }
    // _listFocusNode.dispose();
    _focus.dispose();
  }

  void _onFocusChange() {
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

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

  List<TextEditingController> _controllers = [];
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<Reminders>(context);
    final listReminder = data.itemsList;
    final reminderList = data.tentaviveSchedule_item;
    for (int i = 0; i < reminderList.length; i++) {
      _listFocusNode.add(FocusNode());
      _listFocusNode[i].addListener(_onFocusChange);
    }
    // final product = productsdata.tentativeSchedule;
    return Scaffold(
      appBar: AppBar(title: const Text("Lịch Dự kiến")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              'Lịch dự kiến',
              style: TextStyle(
                  fontSize: 25, color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 15),
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height - 100,
              child: ListView.builder(
                  itemCount: reminderList.length,
                  itemBuilder: (context, index) {
                    _controllers.add(TextEditingController());
                    // _listFocusNode.add(FocusNode());
                    // setState((){
                    //   _listFocusNode[index].addListener(_onFocusChange);
                    // });
                    // _listFocusNode[index].addListener(_onFocusChange);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            '${DateFormat('EEEE').format(reminderList[index].dateTime)} ${DateFormat.Md().format(reminderList[index].dateTime)}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Container(
                            // height: 100,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount:
                                  reminderList[index].tenlistreminder.length,
                              itemBuilder: (context, index2) => ListTile(
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(reminderList[index]
                                        .tenlistreminder[index2]
                                        .title
                                        .toString()),
                                    Text(
                                      data.getnameList(reminderList[index]
                                          .tenlistreminder[index2]
                                          .idList
                                          .toString()),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.notes),
                                  onPressed: () {
                                    _startNewReminder(
                                      context,
                                      reminderList[index]
                                          .tenlistreminder[index2]
                                          .id,
                                      reminderList[index]
                                          .tenlistreminder[index2]
                                          .idList,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: _controllers[index],
                          focusNode: _listFocusNode[index],
                          decoration: const InputDecoration(
                            hintText: 'Lời nhắc mới!',
                            border: InputBorder.none,
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
      floatingActionButton: IconButton(
        icon: Icon(Icons.abc),
        onPressed: () {
          data.tempprint();
        },
      ),
    );
  }
}
