import 'package:flutter_test/flutter_test.dart';
import 'package:lys_wedding/services/auth.services.dart';

void main() => group("logins", () {
      test("desc", (() async {
        final cat = await AuthCalls.login({
          "email": "maaa@gmail.com",
          "password": "123456",
        });
        print(cat);
        expect(cat.statusCode, 200);
      }));
    });
