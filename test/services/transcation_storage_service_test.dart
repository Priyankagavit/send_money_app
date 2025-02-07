import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/services/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:send_money_app/model/transcation_model.dart';

void main() {
  late TransactionStorageService transactionStorageService;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    transactionStorageService = TransactionStorageService();
  });
  group('TransactionStorageService Test Case', () {
    test('saves and loads transactions correctly', () async {
      final transactions = [
        Transaction(
            id: '1', amount: 100.0, date: DateTime.now(), type: 'credit')
      ];

      await transactionStorageService.saveTransactions(transactions);
      final loadedTransactions =
          await transactionStorageService.loadTransactions();

      expect(loadedTransactions.length, transactions.length);
      expect(loadedTransactions.first.id, transactions.first.id);
    });

    test('clears transactions', () async {
      final transactions = [
        Transaction(
            id: '1', amount: 100.0, date: DateTime.now(), type: 'credit')
      ];

      await transactionStorageService.saveTransactions(transactions);
      await transactionStorageService.clearTransactions();
      final loadedTransactions =
          await transactionStorageService.loadTransactions();

      expect(loadedTransactions.isEmpty, true);
    });
  });
}
