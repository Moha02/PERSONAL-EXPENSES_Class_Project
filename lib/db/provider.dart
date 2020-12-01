import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:project/services/transaction.dart';
import '../services/transaction_list.dart';
import '../db/db.dart';

class Trans with ChangeNotifier {
  List<Transaction> _list = [];

  List<Transaction> get list {
    return [..._list];
  }

    void addTransaction(
      String title,
      double amount,
      int id,
      DateTime date) {
      final transactions = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: null);
      _list.add(transactions);
      notifyListeners();
      DB.insert("user_data", {
        "id": transactions.id,
        'title': transactions.title,
        'amount': transactions.amount,
        "date": transactions.date
      });
    }
    Future<void> fetchData() async {
    final dataList = await DB.getData('user_data');
    _list = dataList
        .map((transactions) => Transaction(
            id: transactions['date'],
            date: transactions['date'],
            title: transactions['title'],
            amount: transactions['amount']))
        .toList();
        notifyListeners();
        return _list;
  }
}
