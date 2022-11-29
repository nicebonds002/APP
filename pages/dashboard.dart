import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menu_app/database/db_helper.dart';
import 'package:menu_app/pages/notification.dart';
import 'package:menu_app/widget/list_transactions.dart';
import 'package:menu_app/widget/top_card.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'plan.dart' as globals;

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  DbHelper dbHelper = DbHelper();
  double totalBalance = 0;
  double totalIncome = 0;
  double totalExpense = 0;

  getTotalBalance(Map entireData){
    totalBalance = 0;
    totalIncome = 0;
    totalExpense = 0;

    entireData.forEach((key, value) {
      if(value['type'] == "Income"){
        totalBalance += (value['amount']);
        totalIncome += (value['amount']);
      } else {
        totalBalance -= (value['amount']);
        totalExpense += (value['amount']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: NewGradientAppBar(
        title: const Text('Dashboard'),
        gradient: LinearGradient(colors: [Colors.green,Colors.lightGreen]),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {              
              Navigator.push(
                context,MaterialPageRoute(builder: (context) => Notifications()),
              );},
          ),
          IconButton(
            onPressed: (){
              showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('WARNING!'),
                    content: Text('All your data will be deleted'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          DbHelper dbHelper = DbHelper();
                          dbHelper.cleanAllData();
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text('Cancel')
                      )
                    ]
                  );
                }
              );
            }, 
            icon: const Icon(Icons.delete_rounded),
          )
        ],
      ),
      body: FutureBuilder<Map>(
        future: dbHelper.fetch(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text('Error!'),
            );
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(
                child: Text('No values found!'),
              );
            }
            getTotalBalance(snapshot.data!);
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TopNeuCard(balance: '$totalBalance'),
                    SizedBox(height: 150.0),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  reverse: true,
                                  itemBuilder: (context, index) {
                                      Map dataAtIndex = snapshot.data![index];
                                      return MyTransaction(transactionName: dataAtIndex['description'], money: dataAtIndex['amount'].toString(), expenseOrIncome: dataAtIndex['type']);
                                  }
                                )
                              ),
                              SizedBox(height:0.0),
                              Expanded(
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [ElevatedButton(                
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10.0),
                                          )
                                        )
                                      ),
                                      onPressed: (){
                                        dbHelper.addGoal(-totalBalance, '0', DateTime.now());
                                        dbHelper.clearData();
                                      }, 
                                      child: Text('Finished day'
                                      )
                                    ),
                              ],
                              ),
                                )
                              )
                            ]
                            )
                          )
                        ),
                      )
                  ]
                )
              )
            );
          } else {
            return Center(
              child: Text('Error'),
            );
          }
        }
      )
    );
  }
}