import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:send_money_app/bloc/user_bloc.dart';
import 'package:send_money_app/bloc/user_state.dart';
import 'package:send_money_app/model/transcation_model.dart';
import 'package:send_money_app/ui/transcations.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();

    // Stub the state
    when(() => mockUserBloc.state).thenReturn(
      const UserState(balance: 500.0, transactions: [], isAuthenticated: true),
    );

    // Stub the stream correctly
    when(() => mockUserBloc.stream).thenAnswer(
      (_) => Stream.value(
        const UserState(
            balance: 500.0, transactions: [], isAuthenticated: true),
      ),
    );
  });

  Widget createTestWidget() {
    return MaterialApp(
      home: BlocProvider<UserBloc>.value(
        value: mockUserBloc,
        child: const TransactionsScreen(),
      ),
    );
  }

  group('TransactionsScreen Test Case', () {
    testWidgets('displays "No transactions yet" when transaction list is empty',
        (tester) async {
      when(() => mockUserBloc.state).thenReturn(
        const UserState(
            balance: 500.0, transactions: [], isAuthenticated: true),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.text('No transactions yet'), findsOneWidget);
    });

    testWidgets('displays list of transactions correctly', (tester) async {
      final transactions = [
        Transaction(id: '1', amount: 200.0, date: DateTime.now(), type: 'send'),
        Transaction(
            id: '2', amount: 100.0, date: DateTime.now(), type: 'receive'),
      ];

      when(() => mockUserBloc.state).thenReturn(
        UserState(
            balance: 500.0, transactions: transactions, isAuthenticated: true),
      );

      await tester.pumpWidget(createTestWidget());

      expect(find.text('₱200.00'), findsOneWidget);
      expect(find.text('₱100.00'), findsOneWidget);
      expect(find.byIcon(Icons.send), findsOneWidget);
      expect(find.byIcon(Icons.receipt), findsOneWidget);
    });

    testWidgets('shows correct icon colors for send and receive transactions',
        (tester) async {
      final transactions = [
        Transaction(id: '1', amount: 300.0, date: DateTime.now(), type: 'send'),
        Transaction(
            id: '2', amount: 150.0, date: DateTime.now(), type: 'receive'),
      ];

      when(() => mockUserBloc.state).thenReturn(
        UserState(
            balance: 500.0, transactions: transactions, isAuthenticated: true),
      );

      await tester.pumpWidget(createTestWidget());

      final sendIcon = tester.widget<Icon>(find.byIcon(Icons.send));
      final receiveIcon = tester.widget<Icon>(find.byIcon(Icons.receipt));

      expect(sendIcon.color, Colors.red);
      expect(receiveIcon.color, Colors.green);
    });
  });
}
