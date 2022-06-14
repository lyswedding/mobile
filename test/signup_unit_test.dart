import 'package:flutter_test/flutter_test.dart';
import 'package:lys_wedding/services/auth.services.dart';

void main() => group("register", () {
      test("create accunt", (() async {
        final cat = await AuthCalls.signup({
          "firstName": "aaa",
          "lastName": "aaa",
          "email": "aa@gmail.com",
          "password": "123123",
          "phone": 26409646,
        });
        print(cat);
        expect(cat.statusCode, 201);
      }));
    });
