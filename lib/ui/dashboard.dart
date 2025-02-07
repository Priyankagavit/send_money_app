import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import '../bloc/user_state.dart';
import '../services/network_connectivity.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _balanceVisible = true;
  bool _isOnline = true;

  @override
  void initState() {
    super.initState();
    // Check initial connectivity
    _checkConnectivity();

    // Listen to connectivity changes
    context.read<ConnectivityService>().connectivityStream.listen((result) {
      setState(() {
        _isOnline = result != ConnectivityResult.none;
      });
    });
  }

  void _checkConnectivity() async {
    final isConnected =
        await context.read<ConnectivityService>().checkConnectivity();
    setState(() {
      _isOnline = isConnected;
    });
  }

  void _toggleBalanceVisibility() {
    setState(() {
      _balanceVisible = !_balanceVisible;
    });
  }

  void _logout() {
    context.read<UserBloc>().add(LogoutEvent());
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          return Column(
            children: [
              // Connectivity Status Banner
              if (!_isOnline)
                Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(8),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_wifi_off, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        'Offline Mode',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

              // Dashboard Content
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Wallet Balance',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              IconButton(
                                icon: Icon(_balanceVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onPressed: _toggleBalanceVisibility,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Text(
                        _balanceVisible
                            ? '₱${state.balance.toStringAsFixed(2)}'
                            : '******',
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _isOnline
                            ? () =>
                                Navigator.of(context).pushNamed('/send-money')
                            : null,
                        child: const Text('Send Money'),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed('/transactions'),
                        child: const Text('View Transactions'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
