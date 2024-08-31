import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../utils/app_colors.dart';
import '../viewModels/transaction_viewModel.dart';
import '../widgets/input_field.dart';
import '../widgets/insert_photo.dart';
import '../widgets/search_transaction.dart';
import '../widgets/transaction_list.dart';
import '../widgets/transaction_title.dart';
import '../widgets/type_selector.dart';
import 'transaction_history_view.dart';
class TransactionManager extends StatelessWidget {
  const TransactionManager({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TransactionViewModel vm  = context.watch<TransactionViewModel>();
    vm.getTransactions();
    vm.getCategories();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        //scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:    Column(
            children: [
              TypeSelector(
                  onSelect: (val)
                  {
                    vm.type =val;
                    vm.getCategories();
                  },
                  selectedType : vm.type,
              ),
              const SizedBox( height: 10,),
              InputFiled(
                controller: vm.dateController,
                readOnly: true,
                hintText: "Select Transaction Date",
                labelText: "Transaction Date",
                preIcon: const Icon(Icons.calendar_month),
                onTap: ()
                {

                },
              ),

              const SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.blue,
                    width: 1
                  )
                ),
                child: ExpansionTile(
                  key: Key(vm.category),
                    title: Text(vm.category),
                  leading: const Icon(Icons.category),
                  children: vm.categories.map((e) => ListTile(
                    title: Text(e),
                    onTap: ()
                    {
                      vm.category = e;
                    },
                  )).toList(),
                ),
              ),
              const SizedBox(height: 10,),
              InputFiled(
                keyboard: TextInputType.number,
                  controller: vm.amountController,
                hintText: "Enter amount Here",
                labelText: "Amount",
                preIcon: const Icon(Icons.monetization_on),
              ),
              const SizedBox(height: 10,),
              InputFiled(
                controller: vm.noteController,
                hintText: "Enter Note Here",
                labelText: "Note",
                preIcon: const Icon(Icons.note),
              ),
              const SizedBox(height: 10,),
              InputFiled(
                controller: vm.descController,
                hintText: "Enter Description Here",
                labelText: "Description",
                preIcon: const Icon(Icons.description),
              ),

              const SizedBox(height: 10,),

              const Text('Select Photo',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17),),

              const SizedBox(
                height: 10,
              ),


              InsertPhoto(
                 onSelect: (val)
                     {
                       vm.imagePath=val;
                     }
             ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
                    child:ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all((AppColors.primaryColor)),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
                          )
                      ),
                      onPressed: () {
                        if (vm.update == true )
                        {
                          vm.updateTransaction(context);
                          vm.clearData();

                          Navigator.pop(context);
                          Navigator.pop(context);
                        } else {
                          vm.saveTransaction(context);
                          vm.clearData();
                        }
                      },
                      child: Text('Save ${vm.type}',style: const TextStyle(fontWeight: FontWeight.w500,fontSize: 17)),
                    )
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(10.0),
              //   child: SizedBox(
              //       height: 40,
              //       width: MediaQuery.of(context).size.width,
              //       child: OutlinedButton(
              //         style: ButtonStyle(
              //             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))
              //             )
              //         ),
              //         onPressed: () {
              //
              //           Navigator.push(context, MaterialPageRoute(builder: (context)=> const TransactionDataTable()));
              //         },
              //         child: const Text('Show all Transactions',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 17)),
              //
              //       )
              //   ),
              // ),

              const TransactionTitle(title: 'All Transactions',),

              ListView.builder(
                  itemCount:  vm.transactions.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index)
                  {
                    return TransactionListWidget(
                      category: '${vm.transactions[index].category}',
                      type: '${vm.transactions[index].type}',
                      date: DateFormat("dd-MMM-yyyy").format(vm.transactions[index].transactionDate!),
                      note: '${vm.transactions[index].note}',
                      amount: '${vm.transactions[index].amount}',
                      edit: (){
                        vm.loadData(vm.transactions[index]);
                      },
                      delete: (){
                        vm.deleteTransaction(vm.transactions[index], context);
                      },
                    );


                  }
              ),
              SearchTrnsaction(),


            ],
          ),

        ),
      )
    );
  }
}
