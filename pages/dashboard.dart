import 'package:flutter/material.dart';
import 'package:menu_app/database/db_helper.dart';
import 'package:menu_app/pages/notification.dart';
import 'package:menu_app/widget/list_transactions.dart';
import 'package:menu_app/widget/top_card.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

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
              DbHelper dbHelper = DbHelper();
              dbHelper.cleanData();
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
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TopNeuCard(balance: '$totalBalance'),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 0.0),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) {
                                    Map dataAtIndex = snapshot.data![index];
                                    return MyTransaction(transactionName: dataAtIndex['description'], money: dataAtIndex['amount'].toString(), expenseOrIncome: dataAtIndex['type']);
                                  }
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