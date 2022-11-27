import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
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
                  Icons.warning_amber_rounded,
                  size: 24.0,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18.0),
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