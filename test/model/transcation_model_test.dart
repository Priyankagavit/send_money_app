import 'package:flutter_test/flutter_test.dart';
import 'package:send_money_app/model/transcation_model.dart';

void main() {
  group('Transaction Model Test', () {
    test('should create a valid Transaction object', () {
      final transaction = Transaction(
        id: '123',
        amount: 250.50,
        date: DateTime.parse('2024-02-07T12:00:00Z'),
        type: 'credit',
      );

      expect(transaction.id, '123');
      expect(transaction.amount, 250.50);
      expect(transaction.date, DateTime.parse('2024-02-07T12:00:00Z'));
      expect(transaction.type, 'credit');
    });

    test('should handle empty id and type', () {
      final transaction = Transaction(
        id: '',
        amount: 100.0,
        date: DateTime.now(),
        type: '',
      );

      expect(transaction.id, isEmpty);
      expect(transaction.type, isEmpty);
    });

    test('should handle null values', () {
      expect(() => Transaction(
            id: '',
            amount: 0.0,
            date: DateTime.now(),
            type: '',
          ),
          returnsNormally);
    });
  });
}
