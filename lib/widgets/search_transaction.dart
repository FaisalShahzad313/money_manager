import 'package:flutter/material.dart';
import 'package:money_manager/viewModels/transaction_viewModel.dart';
import 'package:money_manager/widgets/input_field.dart';
import 'package:provider/provider.dart';

class SearchTrnsaction extends StatelessWidget {
  const SearchTrnsaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TransactionViewModel vm  = context.watch<TransactionViewModel>();
    return InputFiled(
        controller: vm.searchController,
            labelText: "search",
      onChanged: (val)
      {
        vm.searchTransaction();
      },
    );
  }
}
