import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:send_money_app/bloc/user_bloc.dart';
import 'package:send_money_app/bloc/user_state.dart';
import 'package:send_money_app/services/network_connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:send_money_app/ui/dashboard.dart';

class MockUserBloc extends Mock implements UserBloc {}

class MockConnectivityService extends Mock implements ConnectivityService {}

void main() {
  late MockUserBloc mockUserBloc;
  late MockConnectivityService mockConnectivityService;

  setUp(() {
    mockUserBloc = MockUserBloc();
    mockConnectivityService = MockConnectivityService();

    when(() => mockUserBloc.state).thenReturn(
      const UserState(isAuthenticated: true, balance: 100.0, transactions: []),
    );

    when(() => mockUserBloc.stream).thenAnswer(
      (_) => Stream.value(const UserState(
          isAuthenticated: true, balance: 100.0, transactions: [])),
    );

    when(() => mockConnectivityService.connectivityStream)
        .thenAnswer((_) => Stream.value(ConnectivityResult.wifi));

    when(() => mockConnectivityService.checkConnectivity())
        .thenAnswer((_) async => true);
  });

  group('DashboardScreen Test Case', () {
    testWidgets('renders DashboardScreen and shows balance', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<UserBloc>.value(value: mockUserBloc),
              RepositoryProvider<ConnectivityService>.value(
                  value: mockConnectivityService),
            ],
            child: const DashboardScreen(),
          ),
        ),
      );

      expect(find.text('Dashboard'), findsOneWidget);
      expect(find.text('Wallet Balance'), findsOneWidget);
      expect(find.text('₱100.00'), findsOneWidget);
      expect(find.text('Send Money'), findsOneWidget);
      expect(find.text('View Transactions'), findsOneWidget);
    });

    testWidgets('toggles balance visibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MultiBlocProvider(
            providers: [
              BlocProvider<UserBloc>.value(value: mockUserBloc),
              RepositoryProvider<ConnectivityService>.value(
                  value: mockConnectivityService),
            ],
            child: const DashboardScreen(),
          ),
        ),
      );

      final visibilityIcon = find.byIcon(Icons.visibility);
      expect(visibilityIcon, findsOneWidget);

      await tester.tap(visibilityIcon);
      await tester.pump();

      expect(find.text('******'), findsOneWidget);
    });
  });
}
