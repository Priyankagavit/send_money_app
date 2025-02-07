import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:send_money_app/services/network_connectivity.dart';
import 'bloc/user_bloc.dart';
import 'ui/index.dart';
void main() {
  final connectivityService = ConnectivityService();
  runApp(
    MultiProvider(
      providers: [
        BlocProvider(create: (context) => UserBloc()),
        Provider.value(value: connectivityService),
      ],
      child: const SendMoneyApp(),
    ),
  );
}

class SendMoneyApp extends StatelessWidget {
  const SendMoneyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Send Money App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/send-money': (context) => const SendMoneyScreen(),
        '/transactions': (context) => const TransactionsScreen(),
      },
    );
  }
}
