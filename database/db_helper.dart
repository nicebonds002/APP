import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DbHelper {
  late Box box;
  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box('money');
  }

  Future addData(double amount, DateTime date, String type, String description) async{
    var value = {'amount': amount, 'date': date, 'type': type, 'description': description};
    box.add(value);
  }

  Future addDaily(double amount, DateTime date, String type, String description) async{
    var cron = new Cron();    
    var value = {'amount': amount, 'date': date, 'type': type, 'description': description};
    cron.schedule(new Schedule.parse('*/1 * * * *'), () async {
    box.add(value);
  });


  }

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }

  Future cleanData() async {
    await box.clear();
  }
}