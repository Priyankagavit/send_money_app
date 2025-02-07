import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:send_money_app/bloc/user_bloc.dart';
import 'package:send_money_app/bloc/user_event.dart';
import 'package:send_money_app/bloc/user_state.dart';
import 'package:send_money_app/ui/index.dart';

import 'package:send_money_app/ui/send_money.dart';

class MockUserBloc extends Mock implements UserBloc {}

class FakeAddTransactionEvent extends Fake implements AddTransactionEvent {}

class FakeUpdateBalanceEvent extends Fake implements UpdateBalanceEvent {}

void main() {
  late MockUserBloc mockUserBloc;
  setUpAll(() {
    registerFallbackValue(FakeAddTransactionEvent());
    registerFallbackValue(FakeUpdateBalanceEvent());
  });

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
        child: const SendMoneyScreen(),
      ),
    );
  }

  group('Send money screen Test Case', () {
    testWidgets('should enter amount and submit transaction successfully',
        (tester) async {
      await tester.pumpWidget(createTestWidget());

      final amountField = find.byType(TextField);
      final submitButton = find.text('Submit');

      // Enter valid amount
      await tester.enterText(amountField, '100');
      await tester.tap(submitButton);
      await tester.pump();

      // Check for success bottom sheet
      await tester.pumpAndSettle();
      expect(find.text('Transaction Successful!'), findsOneWidget);
    });

    testWidgets('should show error bottom sheet for invalid amount',
        (tester) async {
      await tester.pumpWidget(createTestWidget());

      final amountField = find.byType(TextField);
      final submitButton = find.text('Submit');

      // Enter invalid amount (empty)
      await tester.enterText(amountField, '');
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Check for failure message
      expect(find.text('Transaction Failed. Please check the amount.'),
          findsOneWidget);
    });

   
  });
}
