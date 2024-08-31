import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/dashboard_viewmodel.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:provider/provider.dart';

class DashBoardView extends StatelessWidget {
  const DashBoardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionViewModel vM = context.read<TransactionViewModel>();
    vM.getTransactions();
    DashboardViewModel vm = context.watch<DashboardViewModel>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Money Manager"),
      ),
      body: vm.views[vm.index],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.add_circle),
            label: "Add New"
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: "Home"
          ),
          BottomNavigationBarItem(
              icon: const Icon(Icons.category),
              label: "Category"
          ),
         // BottomNavigationBarItem(
           //   icon: Icon(Icons.search),
           // label: "Search Transaction"
          //)

        ],
        onTap: (val)
        {
          vm.index = val;
        },
      ),
    );
  }
}
