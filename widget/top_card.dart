import 'package:flutter/material.dart';

class TopNeuCard extends StatelessWidget {
  final String balance;

  TopNeuCard({
    required this.balance,
  });
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 40,
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Colors.green[700],
        ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,          
            children: [
              SizedBox(width: 15.0),
              Text('TODAY BALANCE',
                  style: TextStyle(color: Colors.green[100], fontSize: 12)),
              SizedBox(width: 40.0),
              Text(
                 balance + '\ ฿',
                style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
              ),            

            ]            

          )            

        ),
    );
  }
}