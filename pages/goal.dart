import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_app/widget/current_goal.dart';
import 'package:menu_app/widget/top_card.dart';

final TextEditingController _9Controller = TextEditingController();
final TextEditingController _10Controller = TextEditingController();
final TextEditingController _11Controller = TextEditingController();

class Goal extends StatefulWidget {
  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
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
              style: TextStyle(fontSize: 18.0)
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
              MyGoal(goal_description: _9Controller.text, goal_amount: _10Controller.text, goal_target: _11Controller.text);
            },
              child: Text('Submit')     
   
              ),
      ),
            ],
          ),      
          SizedBox(height: 30.0),
          Text('Current Goal',style: TextStyle(fontWeight: FontWeight.bold),
      ),
      SizedBox(height:20.0),
      MyGoal(goal_description: _9Controller.text, goal_amount: _10Controller.text, goal_target: _11Controller.text),
  
        ]
      )
    );
  }
}