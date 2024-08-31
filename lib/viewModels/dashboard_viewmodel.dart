import 'package:flutter/material.dart';
import 'package:money_manager/views/category_manager.dart';
import 'package:money_manager/views/home_view.dart';
import 'package:money_manager/views/transaction_manager.dart';
import 'package:money_manager/widgets/search_transaction.dart';

class DashboardViewModel extends ChangeNotifier
{
  int _index = 1;
  int get index => _index;
  set index(int val)
  {
    _index = val;
    notifyListeners();
  }
  final views = const[
    TransactionManager(),
    HomeView(),
    CategoryManager(),
    SearchTrnsaction()
  ];
}