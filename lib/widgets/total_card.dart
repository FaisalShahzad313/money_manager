import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TotalCard extends StatelessWidget {
  final String title;
  final String value;
  const TotalCard({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.all(20),
      width: MediaQuery.of(context).size.width*0.40,
      height: 120,
      decoration: BoxDecoration(
          color: Colors.lightBlueAccent,
          borderRadius: BorderRadius.circular(15)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.monetization_on),
          Text("$title ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
          Text("$value ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),)
        ],
      ),
    );
  }
}
