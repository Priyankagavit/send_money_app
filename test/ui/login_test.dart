import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:send_money_app/bloc/user_bloc.dart';
import 'package:send_money_app/bloc/user_state.dart';
import 'package:send_money_app/ui/login.dart';

class MockUserBloc extends Mock implements UserBloc {}

void main() {
  late MockUserBloc mockUserBloc;

  setUp(() {
    mockUserBloc = MockUserBloc();

    when(() => mockUserBloc.state).thenReturn(
      const UserState(isAuthenticated: false, balance: 0.0, transactions: []),
    );

    when(() => mockUserBloc.stream).thenAnswer(
      (_) => Stream.fromIterable([
        const UserState(isAuthenticated: false, balance: 0.0, transactions: []),
        const UserState(
            isAuthenticated: true, balance: 100.0, transactions: []),
      ]),
    );
  });

  group('Login Screen Test Case', () {
    testWidgets('renders LoginScreen with username and password fields',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      expect(find.text('Send Money App'), findsOneWidget);
      expect(find.byType(TextField), findsNWidgets(2));
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('shows error message for invalid credentials', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<UserBloc>.value(
            value: mockUserBloc,
            child: const LoginScreen(),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).at(0), 'wrongUser');
      await tester.enterText(find.byType(TextField).at(1), 'wrongPass');
      await tester.tap(find.text('Login'));
      await tester.pump();

      expect(find.text('Invalid Credentials'), findsOneWidget);
    });
  });
}
