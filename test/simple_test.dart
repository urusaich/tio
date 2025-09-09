import 'package:test/test.dart';
import 'package:tio/tio.dart';

import '_internal.dart';

void main() {
  test('tio factory config', () {
    final factoryConfig = TioFactoryConfig<int>(
      jsonFactories: {
        User.fromJson,
      },
      errorStringFactory: (string) => int.tryParse(string) ?? 0,
      errorJsonFactory: (json) => json['code'] as int,
    );

    expect(factoryConfig.contains<User>(), isTrue);
    expect(factoryConfig.contains<Todo>(), isFalse);
    expect(factoryConfig.get<User>(), isNotNull);
    expect(factoryConfig.get<Todo>(), isNull);
    expect(factoryConfig.errorStringFactory('123'), 123);
    expect(factoryConfig.errorJsonFactory(const {'code': 312}), 312);
  });

  test('tio response', () {
    // ignore: prefer_const_declarations
    final success = const TioResponse<String, int>.success(
      value: 'result',
    );

    // ignore: prefer_const_declarations
    final failure = const TioResponse<String, int>.failure(
      error: 1,
    );

    expect(
      success.withSuccess<bool>((current) => true),
      isA<TioSuccess<bool, int>>()
          .having((success) => success.value, 'result', isTrue),
    );

    expect(
      failure.withSuccess<bool>((current) => true),
      isA<TioFailure<bool, int>>(),
    );
  });
}
