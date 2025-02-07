// User State
import 'package:send_money_app/model/transcation_model.dart';
import 'package:equatable/equatable.dart';

class UserState extends Equatable {
  final bool isAuthenticated;
  final String? username;
  final double balance;
  final List<Transaction> transactions;

  const UserState({
    this.isAuthenticated = false,
    this.username,
    this.balance = 0.0,
    this.transactions = const [],
  });

  UserState copyWith({
    bool? isAuthenticated,
    String? username,
    double? balance,
    List<Transaction>? transactions,
  }) {
    return UserState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      username: username ?? this.username,
      balance: balance ?? this.balance,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, username, balance, transactions];
}