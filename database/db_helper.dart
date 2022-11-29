import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DbHelper {
  late Box box;
  late Box box2;
  late Box box3;
  late Box box4;
  late Box box5;
  DbHelper() {
    openBox();
  }
  openBox() {
    box = Hive.box('money');
    box2 = Hive.box('goal');
    box3 = Hive.box('emergency');
    box4 = Hive.box('plans');
    box5 = Hive.box('treelabels');
  }

  Future addData(double amount, DateTime date, String type, String description) async{
    var value = {'amount': amount, 'date': date, 'type': type, 'description': description};
    box.add(value);
  }

  Future clearData() async {
    await box.clear();
  }

  Future addGoal(double amount, String description, DateTime newDate) async {
    var value = {'amount': amount, 'description': description, 'date': newDate};
    box2.add(value);
  }

  Future clearGoal() async {
    await box2.clear();
  }

  Future clearEmergency() async {
    await box3.clear();
  }

  Future addEmergency(double amount, String description) async {
    var value = {'amount': amount, 'description': description};
    box3.add(value);
  }

  Future addPlans(double amount) async {
    var value = {'amount': amount};
    box4.add(value);
  }

  Future clearPlans() async {
    await box4.clear();
  }

  Future addTree(double amount) async {
    var value = {'amount': amount};
    box5.add(value);  
  }

  Future clearTree() async {
    await box5.clear();
  }

  //Future addDaily(double amount, DateTime date, String type, String description) async{
    //var cron = new Cron();    
    //var value = {'amount': amount, 'date': date, 'type': type, 'description': description};
    //cron.schedule(new Schedule.parse('*/1 * * * * *'), () async {
    //box.add(value);
  //});


  //}

  Future<Map> fetch() {
    if (box.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box.toMap());
    }
  }

  Future<Map> fetch2() {
    if (box2.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box2.toMap());
    }
  }

  Future<Map> fetch3() {
    if (box3.values.isEmpty) {
      return Future.value({});
    } else {
      return Future.value(box3.toMap());
    }
  }

  Future cleanAllData() async {
    await box.clear();
    await box2.clear();
    await box3.clear();
    await box4.clear();
  }
}