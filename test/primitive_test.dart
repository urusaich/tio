import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:test/test.dart';

import '_internal.dart';

void main() {
  final tio = TioTest.main();

  test(
    'todos as string',
    () async => expect(
      tio.service.todosAsString(),
      completion(
        isA<MySuccess<String>>()
            .having((success) => success.value, 'result', jsonEncode(todos)),
      ),
    ),
  );

  test(
    'encoded todos as bytes',
    () async => expect(
      tio.service.todosAsBytes(),
      completion(
        isA<MySuccess<Uint8List>>().having(
          (success) => success.value,
          'result',
          utf8.encode(jsonEncode(todos)),
        ),
      ),
    ),
  );

  test(
    'stream response',
    () async => expect(
      tio.service.todosAsStream(),
      completion(
        isA<MySuccess<ResponseBody>>().having(
          (success) => success.value.stream.expand((e) => e.toList()).toList(),
          'result',
          completion(utf8.encode(jsonEncode(todos))),
        ),
      ),
    ),
  );

  test(
    'empty response',
    () async => expect(
      tio.service.todosAsEmpty(),
      completion(
        isA<MySuccess<void>>()
            .having((success) => success.value, 'result', isNull),
      ),
    ),
  );
}
