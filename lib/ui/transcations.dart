import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_state.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state.transactions.isEmpty) {
            return const Center(
              child: Text('No transactions yet'),
            );
          }

          return ListView.builder(
            itemCount: state.transactions.length,
            itemBuilder: (context, index) {
              final transaction = state.transactions[index];
              return ListTile(
                title: Text('₱${transaction.amount.toStringAsFixed(2)}'),
                subtitle: Text(transaction.date.toString()),
                leading: Icon(
                  transaction.type == 'send' 
                    ? Icons.send 
                    : Icons.receipt,
                  color: transaction.type == 'send' 
                    ? Colors.red 
                    : Colors.green,
                ),
              );
            },
          );
        },
      ),
    );
  }
}