import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:money_manager/widgets/bottom_bar.dart';
import 'package:money_manager/widgets/pie_chart.dart';
import 'package:money_manager/widgets/total_card.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TransactionViewModel vm = context.watch<TransactionViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TotalCard(
                    title: "Income",
                    value: vm.totalIncome.toString()
                ),
                TotalCard(
                    title: "Expense",
                    value: vm.totalIncome.toString()
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            PieChartWidget(
              chartData: vm.incomechartData,
              total: vm.totalIncome,
            ),
            ListView.builder(
              itemCount: vm.incomechartData.length,
              shrinkWrap: true,
              physics: const  NeverScrollableScrollPhysics(),
                itemBuilder: (context, index)
                    {
                      return ListTile(
                        title: Text("${vm.incomechartData[index].title}"),
                        trailing: Text("${vm.incomechartData[index].value}"),
                      );
                    }
            )
          ],
        ),
      ),
    );
  }
}
