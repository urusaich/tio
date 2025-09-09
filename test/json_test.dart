import 'dart:io';

import 'package:test/test.dart';

import '_internal.dart';

void main() {
  final tio = TioTest.main();

  test(
    'get todos, success',
    () async => expect(
      tio.service.todos(),
      completion(
        isA<MySuccess<List<Todo>>>()
            .having((s) => s.value, 'result', unorderedEquals(todos))
            .having((s) => s.hasValue, 'map', isTrue),
      ),
    ),
  );

  test(
    'get first todo, success',
    () async => expect(
      tio.service.todo(todos.first.id),
      completion(
        isA<MySuccess<Todo>>()
            .having((success) => success.value, 'result', todos.first),
      ),
    ),
  );

  test(
    'get wrong todo, failure with 404',
    () async => expect(
      tio.service.todo(0),
      completion(
        isA<MyFailure<Todo>>()
            .having((f) => f.response?.statusCode, 'error', HttpStatus.notFound)
            .having((s) => s.hasValue, 'map', isFalse),
      ),
    ),
  );
}
