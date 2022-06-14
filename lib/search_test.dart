import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_wedding/UI/home/components/shared/search_bar.dart';
import 'package:lys_wedding/UI/search/screens/search.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/service_list.dart';

void main() => group("search", () {
      // testWidgets('avataaar', (WidgetTester tester) async {
      //   final findimage = find.byKey(ValueKey("image"));
      //   await tester.pumpWidget(MaterialApp(home: HomeDetails()));
      //   await tester.pumpAndSettle();
      //   await tester.tap(findimage);
      //   expect(findimage, findsOneWidget);
      // });
      // testWidgets('list prest', (WidgetTester tester) async {
      //   final findprest = find.byKey(ValueKey("list prest"));
      //   await tester.pumpWidget(MaterialApp(home: HomeDetails()));
      //   await tester.pumpAndSettle();
      //   // await tester.tap(findavatar);
      //   expect(findprest, findsOneWidget);
      // });
      // testWidgets('list of list', (WidgetTester tester) async {
      //   final findlist = find.byKey(ValueKey("list of list"));
      //   await tester.pumpWidget(MaterialApp(home: HomeDetails()));
      //   await tester.pump();
      //   // await tester.tap(findavatar);
      //   expect(findlist, findsOneWidget);
      // });
      testWidgets('Search', (WidgetTester tester) async {
        final addphone = find.byKey(ValueKey("search"));

        await tester.pumpWidget(MaterialApp(home: SearchPage()));
        await tester.pumpAndSettle();
        expect(addphone, findsOneWidget);
        final x = addphone.evaluate().first.widget as SearchBar;

        await tester.enterText(addphone, "Maison & Deco");
        expect(find.text("Maison & Deco"), findsOneWidget);
      });
    });
