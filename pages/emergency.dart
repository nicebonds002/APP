import 'package:flutter/material.dart';
import 'package:menu_app/database/db_helper.dart';
import 'package:menu_app/pages/add_emergency.dart';
import 'package:menu_app/pages/add_goal.dart';
import 'package:menu_app/widget/current_goal.dart';
import 'package:menu_app/widget/recent_emergency.dart';


class Emergency extends StatefulWidget {
  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
    DbHelper dbHelper = DbHelper();
    double totalPockets = 0;
  
  getTotalPockets(Map entireData){
    totalPockets = 0;

    entireData.forEach((key, value) {
      totalPockets += (value['amount']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Emergency'),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
        future: dbHelper.fetch3(),
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
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddEmergency()));
                  },
                  child: Text('ADD EMERGENCY')
                 )
              );
            }
            getTotalPockets(snapshot.data!);            
            return Scaffold(
              body: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Text('Recent emergency', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),),
                    SizedBox(height: 0.0),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 1,
                      reverse: true,
                      itemBuilder: (context, index) {
                        index = 0;
                      Map dataAtIndex = snapshot.data![index];
                        return MyEmergency(emergency_amount: '$totalPockets', emergency_description: dataAtIndex['description']);}
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
                    content: Text('Your emergency will be deleted'),
                    actions: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          DbHelper dbHelper = DbHelper();
                          dbHelper.clearEmergency();
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddEmergency()));
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
