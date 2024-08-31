import 'package:flutter/material.dart';

class TypeSelector extends StatelessWidget {
  final Function(String) onSelect;
  final String? selectedType;
  const TypeSelector({Key? key, required this.onSelect,  this.selectedType}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(25)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: (){
              onSelect("Income");
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selectedType == "Income" ? Colors.blue:Colors.white,
                borderRadius: BorderRadius.circular(25)
              ),
              child:  Text("Income", style: TextStyle(color:selectedType =="Income" ? Colors.white:Colors.black,fontWeight: FontWeight.bold),),
            ),
          ),
          GestureDetector(
            onTap: (){
              onSelect("Expense");
            },
            child: Container(
              width: MediaQuery.of(context).size.width*0.45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: selectedType == "Expense" ? Colors.blue : Colors.white,
                  borderRadius: BorderRadius.circular(25)
              ),
              child:  Text("Expense", style: TextStyle(color:selectedType == "Expense" ? Colors.white: Colors.black,fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
    );
  }
}
