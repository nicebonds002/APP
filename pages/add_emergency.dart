import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_app/database/db_helper.dart';

final TextEditingController _12Controller = TextEditingController();
final TextEditingController _13Controller = TextEditingController();

class AddEmergency extends StatefulWidget {
  @override
  _AddEmergencyState createState() => _AddEmergencyState();
}

class _AddEmergencyState extends State<AddEmergency> {
  DbHelper dbHelper = DbHelper();
  double? amount;
  String description = 'Some action';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Emergency'),
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
              controller: _12Controller,
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
                  Icons.warning_amber_rounded,
                  size: 24.0,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  controller: _13Controller,
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                )
              ),
              SizedBox(width: 12.0),
              Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 20),
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
              onPressed: (){
                          if (amount != null && description.isNotEmpty) {
                            DbHelper dbHelper = DbHelper();
                            dbHelper.addEmergency(amount!, description);
                            _12Controller.clear();
                            _13Controller.clear();
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
              ),
      ),
            ],
          ),  
        ]
   ),
    );
  }
}