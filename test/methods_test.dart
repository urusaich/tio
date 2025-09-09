import 'package:test/test.dart';

import '_internal.dart';

void main() {
  final tio = TioTest.main();
  void testMethod(String method, Future<MyResponse<String>> Function() fn) {
    test(
      'method $method',
      () async => expect(
        fn(),
        completion(
          isA<MySuccess<String>>()
              .having((s) => s.value, 'result', method)
              .having(
                (s) => s.response?.requestOptions.method,
                'response.requestOptions.method',
                method,
              ),
        ),
      ),
    );
  }

  testMethod('GET', tio.service.methodGet);
  testMethod('POST', tio.service.methodPost);
  testMethod('PUT', tio.service.methodPut);
  testMethod('HEAD', tio.service.methodHead);
  testMethod('PATCH', tio.service.methodPatch);
  testMethod('DELETE', tio.service.methodDelete);
}
