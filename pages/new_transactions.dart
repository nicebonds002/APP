import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../database/db_helper.dart';

class NewTransactions extends StatefulWidget {
  const NewTransactions({Key? key}) : super(key: key);
  @override
  _NewTransactionsState createState() => _NewTransactionsState();
}

class _NewTransactionsState extends State<NewTransactions> {

  double? amount;
  String description = 'Some actions';
  String type = 'Income';
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2022, 01),
      lastDate: DateTime(2100, 01),
    );
    if(picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Add Transaction'),
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
                  Icons.attach_money_rounded,
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
                  onChanged: (val){
                    try {
                      amount = double.parse(val);
                    } catch (e) {}
                  },
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  keyboardType: TextInputType.number,
                )
              ),
              SizedBox(width: 12.0),
              Text('฿', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
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
                  Icons.description_rounded,
                  size: 24.0,
                  color: Colors.green,
                ),
              ),
              SizedBox(width: 12.0),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Description',
                    border: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 18.0),
                  onChanged: (val){
                    description = val;
                  },
                )
              )
            ],
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
                  Icons.swap_vert_rounded,
                  size: 24.0,
                  color: Colors.green,

                ),
              ),
              SizedBox(width: 12.0),
              ChoiceChip(
                label: Text('Income',
                style: TextStyle(
                  fontSize: 16.0,
                  color: type == 'Income' ? Colors.white : Colors.black,
                )),
                selected: type == 'Income' ? true : false,
                selectedColor: Colors.green,
                onSelected: (val){
                  if(val){
                    setState(() {
                      type = 'Income';                    
                    });
                  }
                },
              ),
              SizedBox(width: 12.0),
                ChoiceChip(
                label: Text('Expense',
                style: TextStyle(
                  fontSize: 16.0,
                  color: type == 'Expense' ? Colors.white : Colors.black,
                )),
                selected: type == 'Expense' ? true : false,
                selectedColor: Colors.green,
                onSelected: (val){
                  if(val){
                    setState(() {
                      type = 'Expense';                    
                    });
                  }
                },
              ),              
        ],
      ),
      SizedBox(height: 20.0),

      SizedBox(
        height : 50.0,
        child : TextButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero)
          ),
          onPressed: () {
            _selectDate(context);
          },
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.edit_calendar_rounded,
                  size: 24.0,
                  color: Colors.green,
                ),
                ),
              SizedBox(width: 12.0),
              Text(
                '${selectedDate.day} / ${selectedDate.month} / ${selectedDate.year}'
              ),
            ],
          ),
      ),
      ),
      SizedBox(height: 20),
      SizedBox(
        height: 30.0,
        child: ElevatedButton(
          onPressed: (){
            if (amount != null && description.isNotEmpty) {
              DbHelper dbHelper = DbHelper();
              dbHelper.addData(amount!, selectedDate, type, description);
              Navigator.of(context).pop();
            } else{
              ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.yellow[200],
                      content: Text(
                        "Please enter a valid Amount !",
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
          child: Text('Add')
          ),
      ),
      ]
    )
    );
  }
}