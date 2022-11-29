import 'package:flutter/material.dart';
import 'package:menu_app/database/db_helper.dart';
import 'package:menu_app/pages/add_goal.dart';
import 'package:menu_app/widget/current_goal.dart';


class Goal extends StatefulWidget {
  @override
  _GoalState createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  DbHelper dbHelper = DbHelper();
  double totalBalances = 0;
  
  getTotalBalances(Map entireData){
    totalBalances = 0;

    entireData.forEach((key, value) {
      totalBalances += (value['amount']);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Goal'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: dbHelper.fetch2(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(
              child: Text('Error!'),
            );
          }
          if(snapshot.hasData){
            if(snapshot.data!.isEmpty){
              return Center(
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    )
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddGoal()));
                  },
                  child: Text('ADD GOAL')
                 )
              );
            }
            getTotalBalances(snapshot.data!);          
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Text('Current Goal', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                    SizedBox(height: 0.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      reverse: true,
                      itemBuilder: (context, index) {
                        index = 0;
                      Map dataAtIndex = snapshot.data![index];
                        return MyGoal(goal_amount: '$totalBalances', goal_description: dataAtIndex['description'], goal_target: dataAtIndex['date']);}
                    ),
                    SizedBox(height: 10.0),
                    ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      )
                    )
                  ),
                  onPressed: () {
                      showDialog(
                context: context, 
                builder: (BuildContext context){
                  return AlertDialog(
                    title: Text('WARNING!'),
                    content: Text('Your goal will be deleted'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          DbHelper dbHelper = DbHelper();
                          dbHelper.clearGoal();
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddGoal()));
                          
                        },
                        child: Text('OK'),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.pop(context);
                        }, 
                        child: Text('Cancel')
                      )
                    ],
                  );
                }
              );    
                  },
                  child: Text('EDIT')
                    )
                  ],
                )
              )
            );         
          } else {
            return Center(
              child: Text('Error!'),
            );
          }
        }
      )
    );
  }
}
