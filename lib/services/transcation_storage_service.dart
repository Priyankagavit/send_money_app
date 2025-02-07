import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/transcation_model.dart';

class TransactionStorageService {
  static const _transactionsKey = 'transactions';

  // Save transactions to local storage
  Future<void> saveTransactions(List<Transaction> transactions) async {
    final prefs = await SharedPreferences.getInstance();
    final transactionJsonList = transactions
        .map((transaction) => {
      'id': transaction.id,
      'amount': transaction.amount,
      'date': transaction.date.toIso8601String(),
      'type': transaction.type,
    })
        .toList();
    await prefs.setString(
        _transactionsKey, json.encode(transactionJsonList));
  }

  // Load transactions from local storage
  Future<List<Transaction>> loadTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    final transactionsJson = prefs.getString(_transactionsKey);

    if (transactionsJson == null) return [];

    final List<dynamic> transactionsList = json.decode(transactionsJson);
    return transactionsList.map((transactionJson) {
      return Transaction(
        id: transactionJson['id'],
        amount: transactionJson['amount'],
        date: DateTime.parse(transactionJson['date']),
        type: transactionJson['type'],
      );
    }).toList();
  }

  // Clear transactions
  Future<void> clearTransactions() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_transactionsKey);
  }
}