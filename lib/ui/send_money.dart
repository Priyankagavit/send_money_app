import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/model/transcation_model.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  final _amountController = TextEditingController();

  void _submitTransaction() {
    final amount = double.tryParse(_amountController.text);
    if (amount != null && amount > 0) {
      // Create transaction
      final transaction = Transaction(
        id: DateTime.now().toString(),
        amount: amount,
        date: DateTime.now(),
        type: 'send',
      );

      // Update balance and add transaction
      context.read<UserBloc>().add(AddTransactionEvent(transaction));
      context.read<UserBloc>().add(
          UpdateBalanceEvent(context.read<UserBloc>().state.balance - amount));

      // Show success bottom sheet
      _showResultBottomSheet(true);
    } else {
      // Show error bottom sheet
      _showResultBottomSheet(false);
    }
  }

  void _showResultBottomSheet(bool success) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              success ? Icons.check_circle : Icons.error,
              color: success ? Colors.green : Colors.red,
              size: 50,
            ),
            const SizedBox(height: 10),
            Text(
              success
                  ? 'Transaction Successful!'
                  : 'Transaction Failed. Please check the amount.',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pushReplacementNamed('/dashboard');
              },
              child: const Text('Ok'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Send Money')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Enter Amount',
                prefixText: '₱ ',
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _submitTransaction,
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
