import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/tentative_schedule_screen.dart';
import '../screens/reminder_today_screen.dart';
import '../providers/reminders.dart';
import '../screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => Reminders(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const HomeScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => const HomeScreen(),
          ReminderTodayCreen.routeName: (context) => ReminderTodayCreen(),
          TentativeScheduleScreen.routeName: (context) =>
              const TentativeScheduleScreen()
        },
      ),
    );
  }
}
