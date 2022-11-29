// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:menu_app/database/db_helper.dart';

enum UnitType {
  salary,
  fixedcost,
  reservedmoney,
  dailycost,
  save,
}

final now = DateTime.now();
final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
int number_month = lastDayOfMonth.day;


final TextEditingController _1Controller = TextEditingController(text: '0');
final TextEditingController _2Controller = TextEditingController(text : '0');
final TextEditingController _3Controller = TextEditingController(text : '0');
final TextEditingController _4Controller = TextEditingController(text : '0');
final TextEditingController _5Controller = TextEditingController(text : '0');
final TextEditingController _6Controller = TextEditingController(text : '0');
final TextEditingController _7Controller = TextEditingController(text : '0');
final TextEditingController _8Controller = TextEditingController(text : '0');



void _convertUnit(UnitType type) {
  double? slr = double.tryParse(_1Controller.value.text) ?? 0;
  double? fx = double.tryParse(_2Controller.value.text) ?? 0;
  double? avb = double.tryParse(_3Controller.value.text) ?? 0;
  double? rm = double.tryParse(_4Controller.value.text) ?? 0;
  double? dc = double.tryParse(_5Controller.value.text) ?? 0;
  double? sv = double.tryParse(_6Controller.value.text) ?? 0;
  double? fsv = double.tryParse(_7Controller.value.text) ?? 0;
  //double flexmoney = (avb - (dc * number_month) - sv);
  //double minfloor = ((flexmoney ~/ (5 * number_month)) as double);
  //double minflex = (5 * number_month * minfloor);
  //double leftover = (flexmoney - minflex);
  //double daliyflex = (minflex / number_month);
  //_7Controller.text = sv + ((avb - (dc * number_month) - sv) - (5 * number_month * (((avb - (dc * number_month) - sv) ~/ (5 * number_month)) as double)));
  //_8Controller.text = (dc + ((5 * number_month * (((avb - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())) / number_month)).toString();

  switch (type) {
    case UnitType.salary:
      _3Controller.text = (slr - fx).toString();
      _7Controller.text = (sv + (((slr - fx) - (dc * number_month) - sv) - (5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())))).toString();
      _8Controller.text = (dc + ((5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())) / number_month)).toString();   
      break;

    case UnitType.fixedcost:
      _3Controller.text = (slr - fx).toString();
      _7Controller.text = (sv + (((slr - fx) - (dc * number_month) - sv) - (5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())))).toString();
      _8Controller.text = (dc + ((5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())) / number_month)).toString();   
      break;

    case UnitType.reservedmoney:
      // TODO: Handle this case.
      break;

    case UnitType.dailycost:
      _3Controller.text = (slr - fx).toString();
      _7Controller.text = (sv + (((slr - fx) - (dc * number_month) - sv) - (5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())))).toString();
      _8Controller.text = (dc + ((5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())) / number_month)).toString();   
      break;
    case UnitType.save:
      _3Controller.text = (slr - fx).toString();
      _7Controller.text = (sv + (((slr - fx) - (dc * number_month) - sv) - (5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())))).toString();
      _8Controller.text = (dc + ((5 * number_month * ((((slr - fx) - (dc * number_month) - sv) ~/ (5 * number_month)).toDouble())) / number_month)).toString();   
      break;
  }

  
}

class Plans extends StatefulWidget {
  @override
  _PlansState createState() => _PlansState();
}

class _PlansState extends State<Plans> {
  bool isDisabled = false;
  DateTime selectedDate = DateTime.now();


  /*final cron = Cron();

  @override
  void initState() {
    scheduletask();
    super.initState();
  }

  scheduletask(){
    //schedule repeated corn job every 1 minute
    cron.schedule(Schedule.parse('3 * * * * *'), () async {
      double max_amount = double.parse(_8Controller.text);
      String check = _8Controller.text;
      if(check != '0'){
      DbHelper dbHelper = DbHelper();                    
      dbHelper.addData(max_amount, selectedDate, 'Income', 'Daily money');
      setState(() {
      });
      }
    });
  }*/


  @override
  Widget build(BuildContext context) {
     return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Plan'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(40.0),
        children: [
          Row(
            children: [
              Text('Salary : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
             Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _1Controller,
                  onChanged: (_) => _convertUnit(UnitType.salary),
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
          Row(
            children: [
              Text('Fixed cost : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
             Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _2Controller,
                  onChanged: (_) => _convertUnit(UnitType.fixedcost),
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18.0),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                )
              ),
              SizedBox(width: 12.0),
              Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Text('Avaliable : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _3Controller,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none)
                  ),
                ), 
                SizedBox(width: 12.0),
                Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),                    
            ],
          ),
          Row(
            children: [
              Text('Reserved money : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
             Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _4Controller,
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18.0),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                )
              ),
              SizedBox(width: 12.0),
              Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 25.0),
          Row(
            children: [
              Text('Daily cost : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
             Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _5Controller,
                  onChanged: (_) => _convertUnit(UnitType.dailycost),
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18.0),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                )
              ),
              SizedBox(width: 12.0),
              Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),          
          Row(
            children: [
              Text('Save : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
             Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _6Controller,
                  onChanged: (_) => _convertUnit(UnitType.save),
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18.0),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                )
              ),
              SizedBox(width: 12.0),
              Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Text('Final Saving : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _7Controller,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none)
                  ),
                ), 
                SizedBox(width: 12.0),
                Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),                    
            ],
          ),
          Row(
            children: [
              Text('Maximum per day : ', style: TextStyle(fontWeight: FontWeight.bold)),         
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  enabled: isDisabled,
                  controller: _8Controller,
                  readOnly: true,
                  decoration: InputDecoration(
                    hintText: '0',
                    border: InputBorder.none)
                  ),
                ), 
                SizedBox(width: 12.0),
                Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),                    
            ],
          ),
          SizedBox(height: 25.0),         
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
              onPressed: isDisabled? (){
                String aaa = _1Controller.text;
                String bbb = _2Controller.text;
                String ccc = _5Controller.text;
                String ddd = _6Controller.text;
                String eee = _4Controller.text;
                double aa = double.parse(_3Controller.text);
                double bb = double.parse(_5Controller.text);
                double cc = double.parse(_6Controller.text);
                double dd = double.parse(_8Controller.text);
                double ee = double.parse(_2Controller.text);
                double ff = double.parse(_1Controller.text);
                double bbcc = cc + (bb * number_month);
                if(bbcc > aa || aaa == '0' || bbb == '0' || ccc == '0') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.yellow[200],
                      content: Text(
                        "Please enter a real possible value!",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        )
                      )
                    )
                  );
                } else {
                  setState((){
                    isDisabled = false;
                    double max_amount = double.parse(_8Controller.text);
                    DbHelper dbHelper = DbHelper();                    
                    dbHelper.addData(max_amount, selectedDate, 'Income', 'Daily money');
                  }
                  );
                }
              }
              : null,
              child: Text('Submit')
              ),
              ),
              SizedBox(width: 10.0),
              SizedBox(height: 20.0),
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
          onPressed: !isDisabled?(){
            setState(() {
              isDisabled = true;
              DbHelper dbHelper = DbHelper();
              dbHelper.clearData();
            });
          }
          : null,
          child: Text('Edit')
              )
              ),
              SizedBox(width: 10.0),
              SizedBox(height: 20.0),
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
          onPressed: !isDisabled?(){
            isDisabled = true;
            setState(() {
              isDisabled = false;
                    double max_amount = double.parse(_8Controller.text);
                    DbHelper dbHelper = DbHelper();                    
                    dbHelper.addData(max_amount, selectedDate, 'Income', 'Daily money');
            });
          }
          : null,
          child: Text('get a money')
              )
              )              
            ],
          ),
        ]
     )
    );
  }
}