import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

import '../utils/app_colors.dart';
import 'transaction_manager.dart';

class TransactionDataTable extends StatelessWidget {
  const TransactionDataTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Center(child: Text('All Transactions',style: TextStyle(color: Colors.black),)),
          ),
          body:
          Consumer<TransactionViewModel>(
              builder: (context, vm, child) {
                vm.getTransactions();
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(20),
                  child:
                  vm.transactions.isEmpty ?
                  const Center(
                      child: Padding(
                          padding: EdgeInsets.all(20.0),
                          child: Text("No Transactions found",
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 25)))
                  ) :

                  DataTable(
                      headingRowColor: MaterialStateProperty.all(AppColors.primaryColor),
                      headingTextStyle: const TextStyle(color: Colors.white),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.primaryColor)),
                      columns: const <DataColumn>[
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Category')),
                        DataColumn(label: Text('Type')),
                        DataColumn(label: Text('Amount')),
                        DataColumn(label: Text('Note')),
                        DataColumn(label: Text('Description')),
                        DataColumn(label: Text('Date')),
                        // DataColumn(label: Text('Image')),
                        DataColumn(label: Text('Edit')),
                        DataColumn(label: Text('Delete')),
                      ],
                      rows: vm.transactions.map((e){
                        return DataRow(
                            cells: <DataCell>[
                              DataCell(Text("${vm.transactions.indexOf(e)+1}")),
                              DataCell(Text('${e.category}')),
                              DataCell(Text('${e.type}')),
                              DataCell(Text('${e.amount}')),
                              DataCell(Text('${e.note}')),
                              DataCell(Text('${e.description}')),
                              DataCell(Text(DateFormat("dd-MMM-yyyy").format(e.transactionDate!))),
                              // DataCell(Text('${e.imagePath}')),
                              DataCell(IconButton(
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
                                            onPressed: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context) => const TransactionManager()));
                                              vm.loadData(e);

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
                                icon: const Icon(Icons.edit,color: Colors.green,),
                              )),
                              DataCell(IconButton(
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
                                              vm.deleteTransaction(e,context);
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
                              ))
                            ]
                        );

                      }).toList()
                  ),
                );
              }
          )
      )
    ;
  }
}