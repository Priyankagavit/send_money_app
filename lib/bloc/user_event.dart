// User Events
import 'package:send_money_app/model/transcation_model.dart';

abstract class UserEvent {}

class LoginEvent extends UserEvent {
  final String username;
  LoginEvent(this.username);
}

class LogoutEvent extends UserEvent {}

class UpdateBalanceEvent extends UserEvent {
  final double newBalance;
  UpdateBalanceEvent(this.newBalance);
}

class AddTransactionEvent extends UserEvent {
  final Transaction transaction;
  AddTransactionEvent(this.transaction);
}