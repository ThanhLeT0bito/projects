import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:reminder_app/screens/reminder_today_screen.dart';
import 'package:reminder_app/screens/tentative_schedule_screen.dart';
import 'package:reminder_app/widgets/my_list.dart';
import '../providers/reminders.dart';
import 'search.dart';

class MainContent extends StatelessWidget {
  const MainContent({Key? key}) : super(key: key);

  Widget buildClipRRect(Icon icon, String titile, Color color, double sizeWidth,
      int quanliti, VoidCallback ontap) {
    return GestureDetector(
      onTap: ontap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Container(
          width: sizeWidth,
          color: Colors.black38,
          padding: const EdgeInsets.all(10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: color,
                  child: icon,
                ),
                Text(
                  quanliti.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(titile),
          ]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Data = Provider.of<Reminders>(context);
    final quanlity = Data.reminderList;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Search(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildClipRRect(
                    const Icon(Icons.calendar_today),
                    'Hôm nay',
                    Colors.blue,
                    MediaQuery.of(context).size.width * 0.45,
                    quanlity.length, () {
                  Navigator.of(context).pushNamed(
                    ReminderTodayCreen.routeName,
                  );
                }),
                buildClipRRect(
                    const Icon(Icons.calendar_month),
                    'Lịch dự kiến',
                    Colors.red,
                    MediaQuery.of(context).size.width * 0.45,
                    quanlity.length, () {
                  Navigator.of(context).pushNamed(
                    TentativeScheduleScreen.routeName,
                  );
                }),
              ],
            ),
            const SizedBox(height: 10),
            buildClipRRect(const Icon(Icons.all_inbox), 'Tất cả',
                Colors.black12, MediaQuery.of(context).size.width, 1, () {}),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Danh sách của tôi',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Nâng cấp',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            const MyList(),
          ],
        ),
      ),
    );
  }
}
