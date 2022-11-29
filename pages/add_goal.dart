import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_app/database/db_helper.dart';
import 'package:menu_app/pages/dashboard.dart';
import 'package:menu_app/widget/current_goal.dart';
import 'package:menu_app/widget/top_card.dart';

final TextEditingController _9Controller = TextEditingController(text: null);
final TextEditingController _10Controller = TextEditingController(text: null);
final TextEditingController _11Controller = TextEditingController(text: null);

class AddGoal extends StatefulWidget {
  @override
  _AddGoalState createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  DbHelper dbHelper = DbHelper();
  double? amount;
  String description = 'Some target';
  double? month;
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Goal'),
        centerTitle: true,
      ),
      body: ListView(
                padding: EdgeInsets.all(40.0),
                children: [
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.description_rounded,
                          size: 24.0,
                          color: Colors.green,
                        )
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: TextField(
                          controller: _9Controller,
                          decoration: InputDecoration(
                          hintText: 'Description',
                          border: InputBorder.none
                          ),
                          style: TextStyle(fontSize: 18.0),
                          onChanged: (val){
                            description = val;
                          },
                        )
                      )
                    ]
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.sports_score_rounded,
                          size: 24.0,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: TextField(
                          controller: _10Controller,
                          decoration: InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                          ),
                          style: TextStyle(fontSize: 18.0),
                          onChanged: (val){
                            try {
                              amount = double.parse(val);
                            } catch (e) {}
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        )
                      ),
                      SizedBox(width: 12.0),
                      Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text('   How many months to achieve the goal?', style: TextStyle(fontSize: 10.0)),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.calendar_month_rounded,
                          size: 24.0,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(width: 12.0),
                      Expanded(
                        child: TextField(
                          controller: _11Controller,
                          decoration: InputDecoration(
                            hintText: '0',
                            border: InputBorder.none,
                          ),
                          onChanged: (val){
                            try {
                              month = double.parse(val);
                            } catch (e) {}
                          },
                          style: TextStyle(fontSize: 18.0),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                        )
                      ),
                      SizedBox(width: 12.0),
                      Text('month', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 30.0,
                        child: ElevatedButton(
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            )
                          )
                        ),
                        onPressed: () {
                          if (amount != null && description.isNotEmpty && month != null) {
                            DbHelper dbHelper = DbHelper();
                            DateTime newDate = new DateTime(selectedDate.year, selectedDate.month + month!.toInt() , selectedDate.day);
                            dbHelper.addGoal(amount!, description, newDate);
                            _9Controller.clear();
                            _10Controller.clear();
                            _11Controller.clear();
                            Navigator.of(context).pop();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                      backgroundColor: Colors.yellow[200],
                      content: Text(
                        "Please enter a valid data !",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        )
                      )
                    )
              );
                          }
                        },
                        child: Text('Submit')     
                      )
                    ),
                  ],
                ),
                ]
              )
    );
            }
}