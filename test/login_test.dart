import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/shared/Appnavigator.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
// import 'login_test.mocks.dart';

// @GenerateMocks([AppNavigatorFactory])
void main() => group("Login", () {
//   void main() {

//   test('empty email returns error string', () {

//     final result = EmailFieldValidator.validate('');
//     expect(result, 'Email can\'t be empty');
//   });

//   test('non-empty email returns null', () {

//     final result = EmailFieldValidator.validate('email');
//     expect(result, null);
//   });

//   test('empty password returns error string', () {

//     final result = PasswordFieldValidator.validate('');
//     expect(result, 'Password can\'t be empty');
//   });

//   test('non-empty password returns null', () {

//     final result = PasswordFieldValidator.validate('password');
//     expect(result, null);
//   });

// }
      // late MockAppNavigatorFactory mockAppNavigatorFactory;
      // setUp(() async {
      //   mockAppNavigatorFactory = MockAppNavigatorFactory();
      //   // when(mockNavigator.(any)).thenAnswer((_) async {});
      // });
      testWidgets('email & password', (WidgetTester tester) async {
        final addEmail = find.byKey(ValueKey("email"));
        await tester.pumpWidget(MaterialApp(home: Login()));
        await tester.pump();
        await tester.enterText(addEmail, "aaaaa");
        expect(find.text("aaaaa"), findsOneWidget);
      });
      testWidgets('shows UI', (WidgetTester tester) async {
        final addEmail = find.byKey(ValueKey("email"));

        final addButton = find.byType(CustomButton);

        final addpassword = find.byKey(ValueKey("password"));

        await tester.pumpWidget(MaterialApp(home: Login()));
        await tester.pump();
        // await tester.enterText(addEmail, "123123");
        expect(addEmail, findsOneWidget);
        expect(addpassword, findsOneWidget);
        expect(addButton, findsOneWidget);
        // expect(find.text("123123"), findsOneWidget);

        // verify(mockObserver.didPush().called(1));
      });
      testWidgets('test skeep button', (WidgetTester tester) async {
        final addSeek = find.byKey(ValueKey("skeep"));
        await tester.pumpWidget(MaterialApp(home: Login()));
        await tester.pump();
        expect(addSeek, findsOneWidget);
        await tester.tap(addSeek);

        // await tester.pumpAndSettle();
      });
      // testWidgets('get password', (WidgetTester tester) async {
      //   final addPassword = find.byKey(ValueKey("password"));
      //   final addButton = find.byKey(ValueKey("Login"));

      //   await tester.pumpWidget(MaterialApp(home: Login()));
      //   await tester.enterText(addPassword, "123456");
      //   await tester.tap(addButton);
      //   await tester.pump();

      //   expect(find.text("123456"), findsOneWidget);
      // });
    });
