import 'package:dio/dio.dart';
import 'package:tio/tio.dart';

class User {
  User.fromJson(JsonMap json) : id = json['id'] as int;

  final int id;
}

class MyError {
  const MyError.fromString(this.errorMessage);

  MyError.fromJson(JsonMap json) : errorMessage = json['message'] as String;

  final String errorMessage;
}

typedef MyResponse<T> = TioResponse<T, MyError>;
typedef MySuccess<T> = TioSuccess<T, MyError>;
typedef MyFailure<T> = TioFailure<T, MyError>;

const factoryConfig = TioFactoryConfig<MyError>(
  jsonFactories: {
    User.fromJson,
  },
  errorJsonFactory: MyError.fromJson,
  errorStringFactory: MyError.fromString,
);

final dio = Dio();
final tio = Tio<MyError>(
  dio: dio, // Tio uses dio under the hood
  factoryConfig: factoryConfig,
);

Future<MyResponse<User>> getUser(int id) => tio.get<User>('/users/$id').one();

Future<MyResponse<List<User>>> getUsers() => tio.get<User>('/users').many();

Future<MyResponse<User>> updateUser(int id, String name) =>
    tio.post<User>('/users/$id', data: {'name': name}).one();

Future<MyResponse<String>> getString() => tio.get<String>('/text').string();

void main() async {
  switch (await getUser(1)) {
    case TioSuccess<User, MyError>(value: final user):
      print('user id is ${user.id}');
    case TioFailure<User, MyError>(error: final error):
      print('error acquired ${error.errorMessage}');
  }

  // ignore: omit_local_variable_types
  final User? user = (await getUser(1)).map(
    success: (success) => success.value,
    failure: (failure) => null,
  );

  // ignore: omit_local_variable_types
  final User? user2 = (await getUser(2)).when(
    success: (value) => value,
    failure: (error) => null,
  );

  // ignore: omit_local_variable_types
  final User? user3 = (await getUser(3)).valueOrNull;
}
