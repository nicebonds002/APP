import 'package:flutter/material.dart';

class MyGoal extends StatelessWidget{
  final String goal_description;
  final String goal_amount;
  final DateTime goal_target;


  MyGoal({
    required this.goal_amount,
    required this.goal_description,
    required this.goal_target
  });


  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color(0xff00b09b), Color(0xff96c93d)
              ],
            ),
        borderRadius: BorderRadius.circular(20),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,          
            children: [
              SizedBox(height: 10.0),
              Text(goal_description,
                  style: TextStyle(color: Colors.green[100], fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 5.0),
              Text('Expired at: ' + '${goal_target.day} - ${goal_target.month} - ${goal_target.year}',
              style: TextStyle(color: Colors.green[900], fontSize: 12, fontWeight: FontWeight.bold)
              ),
              SizedBox(height: 0.0),
              Text(
                 goal_amount + '\ ฿',
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),            
            ],  
          )            
        ),
    );
  }

}