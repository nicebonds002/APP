import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'pages/home.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('money');
  await Hive.openBox('goal');
  await Hive.openBox('emergency');
  await Hive.openBox('plans');
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EXPENSE APP',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Home()
    );
  }
}