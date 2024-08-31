import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/models/chart_model.dart';
import 'package:money_manager/models/transaction_model.dart';
import 'package:money_manager/services/sqlite_service.dart';
import 'package:money_manager/utils/common_functions.dart';
import '../models/category_model.dart';
import 'dart:math' as math;

class TransactionViewModel extends ChangeNotifier
{
  final db = SqliteService.instance;
  final dateController = TextEditingController(text: DateFormat("dd-MMM-yyyy").format(DateTime.now()));
  final amountController = TextEditingController();
  final noteController = TextEditingController();
  final descController = TextEditingController();
  final searchController = TextEditingController();
  final strtdtController = TextEditingController();
  final enddtContrpoller =TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _imagePath = '';
  bool update = false;
  String _id = '';
  double totalIncome = 0;
  double totalExpense = 0;
  List<Color> colors = [];
  List<String> _categories = [];
  String _type = 'income';
  String _category = 'Select Income Category';
  List<Transaction> _transactions = [];
  List<ChartModel> _expensechartData = [];
  List<ChartModel> get expensechartData => _expensechartData;
  List<ChartModel> _incomechartData = [];
  List<ChartModel> get incomechartData => _incomechartData;


  List<Transaction> get transactions => _transactions;
  List<String> get categories => _categories;
  String get type => _type;
  String get category => _category;
  DateTime get selectedDate => _selectedDate;


  set imagePath(String val)
  {
    _imagePath = val;
    notifyListeners();
  }

  set type(String val)
  {
    _type = val;
    notifyListeners();
  }

  set category (String val){
    _category = val;
    notifyListeners();
  }
  set selectedDate(DateTime val)
  {
    _selectedDate = val;
    dateController.text = DateFormat("dd-MMM-yyyy").format(val);
    notifyListeners();
  }

  getCategories() async
  {
    var x = await db.getAllRows("select * from categories where type = '$_type'");
    List<Category> temp = [];
    temp = x.map((e) => Category.fromMap(e)).toList();
    _categories = temp.map((e) => e.name.toString()).toList();
    notifyListeners();
  }

  getTransactions() async {
    var data = await db.getAllRows("Select * from transactions");
    colors = List.generate(_transactions.length, (index) => Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0));
    _transactions = data.map((e) => Transaction.fromMap(e)).toList();
    calculateTotal();
    calculateChartData();
    notifyListeners();

  }
  searchTransaction () async
  {
    var data = await db.getAllRows("select all from transactions where type like '%${searchController.text}%' ");
    _transactions = data.map((e) => Transaction.fromMap(e)).toList();
    notifyListeners();
  }

  saveTransaction(BuildContext context) async
  {
    if(_validate(context))
    {
      String query = "Insert into transactions(category, type, amount , note, description, transactionDate , imagePath) values('$category', '$type','${amountController.text}',  '${noteController.text}', '${descController.text}', '$selectedDate', '$_imagePath')";
      CommonFunctions.showSnackBar(context: context, message: "$_type Successfully Saved");
      var id = await db.insert(query);
      // print('Data Saved $id');
      notifyListeners();
    }
  }

  loadData(Transaction trans)
  {
    _id = trans.id.toString();
    _category = trans.category .toString();
    _type = trans.type.toString();
    amountController.text = trans.amount.toString();
    noteController.text = trans.note.toString();
    descController.text = trans.description.toString();
    dateController.text = DateFormat("dd-MMM-yyyy").format(_selectedDate);
    _selectedDate = trans.transactionDate!;
    imagePath = trans.imagePath.toString();
    update = true;
    notifyListeners();

  }

  void updateTransaction(BuildContext context) async {
    if(_validate(context))
    {

      String query = "Update transactions set category = '$category', type = '$type', amount = '${amountController.text}', note = '${noteController.text}', description = '${descController.text}', transactionDate = '$_selectedDate', imagePath = '$_imagePath' where id = '$_id' ";
      CommonFunctions.showSnackBar(context: context, message: "$_type Successfully Updated");
      var id = await db.update(query);
      //print('Date Updated $id');
      notifyListeners();
    }
  }

  void deleteTransaction (Transaction trans, BuildContext context) async{
    String query = "delete from transactions where id = ${trans.id}";
    CommonFunctions.showSnackBar(context: context, message: "${trans.type } is Successfully Deleted");
    await db.delete(query);
    notifyListeners();
  }

  clearData()
  {
    _category = "Select Income Category";
    type = "income";
    amountController.clear();
    noteController.clear();
    dateController.clear();
    descController.clear();
    notifyListeners();
  }

  bool _validate (BuildContext context)
  {
    bool check = true;

    if(_category == "Select Income Category")
    {
      check = false;
      CommonFunctions.showSnackBar(context: context, message: "Please Select Category");
    }
    else if(amountController.text.trim().isEmpty)
    {
      check = false;
      CommonFunctions.showSnackBar(context: context, message: "Please Enter Amount");
    }
    else if(noteController.text.trim().isEmpty)
    {
      check = false;
      CommonFunctions.showSnackBar(context: context, message: "Please Enter Note");
    }

    return check;
  }
  calculateChartData()
  {
    _expensechartData.clear();
    _incomechartData.clear();
    for(int i=0; i< _transactions.length; i++)
    {
      double sum =0;
      if(_transactions[i].type == "Income")
      {
        for(int j=0; j<_transactions.length; j++)
        {
          if(_transactions[j].category == _transactions[i].category)
          {
            sum += _transactions[j].amount ?? 0;
          }
        }
        _incomechartData.add(
            ChartModel(
                title: _transactions[i].category.toString(),
                value: sum
            )
        );
      }
      else
      {
        {
          for(int j=0; j<_transactions.length; j++)
          {
            if(_transactions[j].category == _transactions[i].category)
            {
              sum += _transactions[j].amount ?? 0;
            }
          }
          _expensechartData.add(
              ChartModel(
                  title: _transactions[i].category.toString(),
                  value: sum
              )
          );
        }
      }
    }
  }

  calculateTotal()
  {
    totalExpense = 0;
    totalIncome = 0;
    for (int i = 0; i< _transactions.length; i++)
    {
      if(_transactions[i].type == "income")
      {
        totalIncome += _transactions[i].amount ?? 0;
      }
      else
      {
        totalExpense += _transactions[i].amount ?? 0;
      }
    }
    notifyListeners();
  }


}