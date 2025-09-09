import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:tio/tio.dart';

import '_internal.dart';

class TestTioService extends TioApi<MyResponseError> {
  const TestTioService({required super.tio});

  Future<MyResponse<String>> methodGet() => tio.get<String>('/method').string();

  Future<MyResponse<String>> methodPost() =>
      tio.post<String>('/method').string();

  Future<MyResponse<String>> methodPut() => tio.put<String>('/method').string();

  Future<MyResponse<String>> methodHead() =>
      tio.head<String>('/method').string();

  Future<MyResponse<String>> methodPatch() =>
      tio.patch<String>('/method').string();

  Future<MyResponse<String>> methodDelete() =>
      tio.delete<String>('/method').string();

  Future<MyResponse<void>> long(CancelToken cancelToken) =>
      tio.get<void>('/long_job', cancelToken: cancelToken).empty();

  Future<MyResponse<List<Post>>> posts() => tio.get<Post>('/posts').many();

  Future<MyResponse<List<User>>> postsAsUsers() =>
      tio.get<User>('/posts').many();

  Future<MyResponse<User>> postAsUser(int id) =>
      tio.get<User>('/posts/$id').one();

  Future<MyResponse<List<Todo>>> todos() => tio.get<Todo>('/todos').many();

  Future<MyResponse<Todo>> todo(int id) => tio.get<Todo>('/todos/$id').one();

  Future<MyResponse<ResponseBody>> todosAsStream() =>
      tio.get<ResponseBody>('/todos').stream();

  Future<MyResponse<String>> todosAsString() =>
      tio.get<String>('/todos').string();

  Future<MyResponse<Uint8List>> todosAsBytes() =>
      tio.get<String>('/todos').bytes();

  Future<MyResponse<void>> todosAsEmpty() => tio.get<void>('/todos').empty();

  Future<MyResponse<User>> error404empty() => tio.get<User>('/404_empty').one();

  Future<MyResponse<User>> error404string() =>
      tio.get<User>('/404_string').one();

  Future<MyResponse<User>> error404json() => tio.get<User>('/404_json').one();

  Future<MyResponse<String>> checkAccessToken() =>
      tio.get<String>('/check_access_token').string();

  Future<MyResponse<RefreshTokenResponse>> refresh() =>
      tio.get<RefreshTokenResponse>('/refresh_access_token').one();
}

class TestTioApiWithPath extends TioApi<MyResponseError> {
  TestTioApiWithPath({required super.tio}) : super(path: '/todos');

  Future<MyResponse<List<Todo>>> todos() => get<Todo>('/').many();

  Future<MyResponse<List<Todo>>> todos2() => get<Todo>('').many();

  Future<MyResponse<Todo>> todo(int id) => get<Todo>('/$id').one();

  Future<MyResponse<Todo>> todo2(int id) => get<Todo>('$id').one();
}

class TestAuthTioService extends TioApi<MyResponseError> {
  TestAuthTioService({required super.tio});

  Future<MyResponse<void>> index() => tio.get<void>('/').empty();

  Future<MyResponse<RefreshTokenResponse>> refresh() =>
      tio.get<RefreshTokenResponse>('/refresh').one();
}
