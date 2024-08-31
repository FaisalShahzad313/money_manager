import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      backgroundColor: Colors.black,
      //selectedItemColor: Colors.white,
      //unselectedItemColor: Colors.grey,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.wallet,color: Colors.grey,),
            label: ""
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.insert_chart,color: Colors.grey,),
            label: ""
        ),

        BottomNavigationBarItem(
            icon: Icon(Icons.add_circle,color: Colors.yellow, size: 50,),
            label: "Add Circle"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.file_copy,color: Colors.grey,),
            label: "person"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined,color: Colors.grey,),
            label: "person"
        ),

      ],
    );
  }
}
