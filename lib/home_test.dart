import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lys_wedding/UI/home/screens/home.dart';
import 'package:lys_wedding/services/categorie.services.dart';
import 'package:lys_wedding/services/favorite.services.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/services/service_list.dart';
import 'package:lys_wedding/services/task_list.services.dart';

void main() => group("home", () {
      // testWidgets('avataaar', (WidgetTester tester) async {
      //   final findimage = find.byKey(ValueKey("image"));
      //   await tester.pumpWidget(MaterialApp(home: HomeDetails()));
      //   await tester.pumpAndSettle();
      //   await tester.tap(findimage);
      //   expect(findimage, findsOneWidget);
      // });
      // // testWidgets('list prest', (WidgetTester tester) async {
      // //   final findprest = find.byKey(ValueKey("list prest"));
      // //   await tester.pumpWidget(MaterialApp(home: HomeDetails()));
      // //   await tester.pumpAndSettle();
      // //   // await tester.tap(findavatar);
      // //   expect(findprest, findsOneWidget);
      // // });
      // testWidgets('list of list', (WidgetTester tester) async {
      //   final findlist = find.byKey(ValueKey("list of list"));
      //   await tester.pumpWidget(MaterialApp(home: HomeDetails()));
      //   await tester.pump();
      //   // await tester.tap(findavatar);
      //   expect(findlist, findsOneWidget);
      // });

      test("categorie service", (() async {
        final cat = await CategorieCalls.getAdminServices();
        print(cat);
        expect(cat.length, 9);
      }));
      test("prest service", (() async {
        final prest = await ServiceList.getPrestataire();
        print(prest);
        expect(prest.length, 9);
      }));
      test("list service", (() async {
        final list = await ListCalls.getAdminLists();
        print(list);
        expect(list.length, 16);
      }));
      test("profil service", (() async {
        ServiceProfil profil = ServiceProfil();
        final profile = await profil.getUser();
        print(profile);
        expect(profile.success, true);
      }));
      test("profil update service", (() async {
        final profile = await ServiceProfil.updateUser("firstName", "aaa");
        print(profile);
        expect(profile.success, true);
      }));
      test("profil updatepassword service", (() async {
        final profile = await ServiceProfil.updateUserPassword(
            {"oldPassword": "123456", "password": "123456789"});
        print(profile);
        expect(profile.success, true);
      }));
      test("favoriteprest service", (() async {
        final favoriteprest = await FavoriteCalls.GetProvidersFavorite();
        print(favoriteprest);
        expect(favoriteprest.length, 2);
      }));
      test("favoritelist service", (() async {
        final favoritelist = await FavoriteCalls.getFavorite();
        print(favoritelist);
        expect(favoritelist.length, 4);
      }));
    });
