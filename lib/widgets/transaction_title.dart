import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/utils/app_colors.dart';


class TransactionTitle extends StatelessWidget {
  final String  title;
  const TransactionTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius:  BorderRadius.all(Radius.circular(20.0)),
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20
            ),
          ),
        ),
      ),
    );
  }
}
