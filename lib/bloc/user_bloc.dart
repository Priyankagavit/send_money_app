import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:send_money_app/bloc/user_event.dart';
import 'package:send_money_app/bloc/user_state.dart';
import '../model/transcation_model.dart';
import '../services/index.dart';


class UserBloc extends Bloc<UserEvent, UserState> {
  final TransactionStorageService _storageService = TransactionStorageService();
  final ConnectivityService _connectivityService = ConnectivityService();

  UserBloc() : super(const UserState()) {
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
    on<UpdateBalanceEvent>(_onUpdateBalance);
    on<AddTransactionEvent>(_onAddTransaction);
    on<LoadTransactionsEvent>(_onLoadTransactions);

    // Initialize connectivity monitoring
    _connectivityService.initialize();
  }

  void _onLogin(LoginEvent event, Emitter<UserState> emit) async {
    // Load previous transactions on login
    final transactions = await _storageService.loadTransactions();
    emit(state.copyWith(
      isAuthenticated: true,
      username: event.username,
      transactions: transactions,
    ));
  }

  void _onLogout(LogoutEvent event, Emitter<UserState> emit) async {
    await _storageService.clearTransactions();
    emit(const UserState());
  }

  void _onUpdateBalance(UpdateBalanceEvent event, Emitter<UserState> emit) {
    emit(state.copyWith(balance: event.newBalance));
  }

  void _onAddTransaction(AddTransactionEvent event, Emitter<UserState> emit) async {
    final updatedTransactions = List<Transaction>.from(state.transactions)
      ..add(event.transaction);

    // Save transactions to local storage
    await _storageService.saveTransactions(updatedTransactions);

    emit(state.copyWith(transactions: updatedTransactions));
  }

  void _onLoadTransactions(LoadTransactionsEvent event, Emitter<UserState> emit) async {
    final transactions = await _storageService.loadTransactions();
    emit(state.copyWith(transactions: transactions));
  }

  @override
  Future<void> close() {
    _connectivityService.dispose();
    return super.close();
  }
}

// Add new event for loading transactions
class LoadTransactionsEvent extends UserEvent {}