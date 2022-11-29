import 'package:flutter/material.dart';

class MyEmergency extends StatelessWidget{
  final String emergency_description;
  final String emergency_amount;


  MyEmergency({
    required this.emergency_amount,
    required this.emergency_description,
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
              Colors.deepOrange, Colors.orange
              ],
            ),
        borderRadius: BorderRadius.circular(20),
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,          
            children: [
              SizedBox(height: 15.0),
              Text(emergency_description,
                  style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold)),
              SizedBox(height: 1.0),
              Text(
                 emergency_amount + '\ ฿',
                style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
              ),            
            ],  
          )            
        ),
    );
  }

}