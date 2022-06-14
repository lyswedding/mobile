// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:lys_wedding/UI/authentification/components/button.dart';
import 'package:lys_wedding/UI/authentification/components/custom_input.dart';
import 'package:lys_wedding/UI/authentification/screens/login.dart';
import 'package:lys_wedding/UI/authentification/screens/signup.dart';
import 'package:lys_wedding/shared/utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

//  group('getPrestataire', () {
//   test('returns an Album if the http call completes successfully', () async {

//     // Use Mockito to return a successful response when it calls the
//     // provided http.Client.
//     when(http
//             .get(Uri.parse('http://102.219.178.96:3001/providers/62331a0557d86678fc2b0995')))
//         .thenAnswer((_) async =>
//             http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

//     expect(await (), isA<Provider>());
//   });
// @GenerateMocks([Navigator])
// class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() => group("sign up", () {
      // late MockNavigator mockNavigator;
      // setUp(() async {
      //   MockNavigator mockNavigator = MockNavigator();
      //   when(mockNavigator.(any)).thenAnswer((_) async {});

      // });
      testWidgets('show UI', (WidgetTester tester) async {
        final addButton = find.byType(CustomButton);

        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
        expect(addButton, findsOneWidget);
      });
      testWidgets('firstname', (WidgetTester tester) async {
        final addfirstname = find.byKey(ValueKey("first name"));

        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
        expect(addfirstname, findsOneWidget);
        await tester.enterText(addfirstname, "aaaaa");
        expect(find.text("aaaaa"), findsOneWidget);
      });

      testWidgets('lastname', (WidgetTester tester) async {
        final addlastname = find.byKey(ValueKey("last name"));

        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
        expect(addlastname, findsOneWidget);
        await tester.enterText(addlastname, "bbbbb");
        expect(find.text("bbbbb"), findsOneWidget);
      });
      testWidgets('email', (WidgetTester tester) async {
        final addEmail = find.byKey(ValueKey("email"));
        final addButton = find.byType(CustomButton);

        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
        expect(addEmail, findsOneWidget);
        await tester.enterText(addEmail, "aaaaa");
        final x = addEmail.evaluate().first.widget as CommonTextFieldView;
        expect(find.text("aaaaa"), findsOneWidget);
        expect(isEmail(x.controller!.text), false);
        expect((x.controller!.text.isEmpty), false);
      });

      testWidgets('password', (WidgetTester tester) async {
        final addpassword = find.byKey(ValueKey("password"));

        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
        expect(addpassword, findsOneWidget);
        await tester.enterText(addpassword, "aaaaaa");
        final x = addpassword.evaluate().first.widget as CommonTextFieldView;

        expect(find.text("aaaaaa"), findsOneWidget);
        expect((x.controller!.text.length < 6), false);
      });
      testWidgets('phone', (WidgetTester tester) async {
        final addphone = find.byKey(ValueKey("phone"));

        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
        expect(addphone, findsOneWidget);
        final x = addphone.evaluate().first.widget as CommonTextFieldView;

        await tester.enterText(addphone, "11111111");
        expect(find.text("11111111"), findsOneWidget);
        expect((x.controller!.text.length < 8), false);
        expect((x.controller!.text.length > 13), false);
      });
      // testWidgets('test seek button', (WidgetTester tester) async {
      //   final addSeek = find.byKey(ValueKey("seek"));
      //   await tester.pumpWidget(MaterialApp(home: Signup()));
      //   await tester.pumpAndSettle();
      //   expect(addSeek, findsOneWidget);
      //   await tester.tap(addSeek);
      //   // verify(mockNavigator()).called(1);
      // });
      testWidgets('test skeepp button', (WidgetTester tester) async {
        final addSeek = find.byKey(ValueKey("seek"));
        await tester.pumpWidget(MaterialApp(home: Signup()));
        await tester.pumpAndSettle();
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
