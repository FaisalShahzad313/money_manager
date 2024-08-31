import 'package:flutter/material.dart';
import 'package:money_manager/utils/app_colors.dart';


class TransactionListWidget extends StatelessWidget {
  final String category;
  final String note;
  final String amount;
  final String type;
  final String date;
  final Function edit;
  final Function delete;

  const TransactionListWidget({Key? key, required this.note, required this.amount, required this.type, required this.date,required this.category, required this.edit, required this.delete,}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return
      Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 1,color: AppColors.primaryColor)
          ),
          child:
          // ListTile(
          //   title: Text(title),
          //   subtitle: Text(amount),
          //   trailing: Text(date),
          //   leading: CircleAvatar(
          //     backgroundColor:  type == "income"?  Colors.green : Colors.red,
          //       child: const Icon(Icons.monetization_on_outlined,color: Colors.white,),
          //        ),
          // )
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(type),
                      Text(category)
                    ],
                  ),
                  ListTile(
                      leading: CircleAvatar(
                        backgroundColor:  type == "income"?  Colors.green : Colors.red,
                        child: const Icon(Icons.monetization_on_outlined,color: Colors.white,),
                      ),
                      title: Text(amount),
                      subtitle: Text(note),

                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  // style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
                  //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12)
                  //     ))
                  // ),
                  onPressed: () {
                    showDialog(context: context, builder: (context)
                    {
                      return AlertDialog(
                        icon: const Icon(Icons.edit,color: Colors.greenAccent,size: 50,),
                        title: const Text("Do you want to Edit this record"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        actions: [
                          TextButton(
                            // ToDo
                              onPressed: (){
                                edit();
                                Navigator.pop(context, true);

                              },
                              child: const Text('yes')),
                          TextButton(
                              onPressed: (){
                                Navigator.pop(context, false);
                              },
                              child: const Text('No'))
                        ],
                      );
                    }
                    );
                  },
                  icon: const Icon(Icons.edit,color: Colors.green,size: 15),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context)
                    {
                      return  AlertDialog(
                        icon: const Icon(Icons.delete_forever, size: 50, color: Colors.red, ),
                        title: const Text("Confirm Delete"),
                        content: const Text("Do you want to delete this record?"),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)
                        ),
                        actions: [
                          TextButton(
                              onPressed: (){
                                delete();
                                Navigator.pop(context, true);
                              },
                              child: const Text("Yes")
                          ),
                          TextButton(
                              onPressed: (){

                                Navigator.pop(context, false);
                              },
                              child: const Text("No")
                          ),
                        ],
                      );
                    }
                    );
                  },
                  icon: const Icon(Icons.delete_forever,color: Colors.red,),
                )
              ],
            )
          ],
        )

      );

  }
}
