import 'package:flutter_test/flutter_test.dart';
import 'package:lys_wedding/services/categorie.services.dart';

void main() => group("categorie", () {
      test("description", (() async {
        final cat = await CategorieCalls.getAdminServices();
        print(cat);
        expect(cat.length, 9);
      }));
    });
