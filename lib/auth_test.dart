import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:lys_wedding/services/profil_service.dart';
import 'package:lys_wedding/shared/sharedPrefValues.dart';
import 'package:lys_wedding/shared/urls.dart';

const successMessage = {'message': 'Success'};
const errorMessage = {'message': 'error'};
const testPath = 'test';
const testData = {'data': 'sample data'};
const header = {'Content-Type': 'application/json'};

void main() {
  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);
  var baseUrl;

  setUp(() {
    dio.httpClientAdapter = dioAdapter;
    baseUrl = '${URLS.BASE_URL}';
  });

  group('- ApiService class methods test', () {
    group('- Get Method', () {
      test('- Get Method Success test', () async {
        dioAdapter.onGet(
          '$baseUrl/users/me',
          (request) {
            return request.reply(200, successMessage);
          },
          data: null,
          queryParameters: {},
          headers: {'bearer': await getUserInfoSharedPref("token")},
        );

        final service = ServiceProfil();

        final response = await service.getUser();

        expect(response, successMessage);
      });
    });
  });
}
