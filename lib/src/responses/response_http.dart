import 'package:dio/dio.dart';

import '../../tio.dart';

abstract class TioHttpResponse<R, E> extends TioResponse<R, E> {
  const TioHttpResponse({required this.response});

  const factory TioHttpResponse.success({
    required R result,
    required Response<dynamic> response,
  }) = TioHttpSuccess;

  const factory TioHttpResponse.failure({
    required E error,
    required Response<dynamic> response,
  }) = TioHttpFailure;

  final Response<dynamic> response;
}

class TioHttpSuccess<R, E> extends TioHttpResponse<R, E>
    implements TioSuccess<R, E> {
  const TioHttpSuccess({
    required this.result,
    required super.response,
  });

  @override
  final R result;

  @override
  TioHttpResponse<T, E> withSuccess<T>(TioResultTransformer<R, E, T> builder) =>
      TioHttpSuccess<T, E>(result: builder(this), response: response);

  // @override
  // List<Object?> get props => [result];
}

class TioHttpFailure<R, E> extends TioHttpResponse<R, E>
    implements TioFailure<R, E> {
  const TioHttpFailure({
    required this.error,
    required super.response,
  });

  @override
  final E error;

  @override
  TioHttpResponse<T, E> withSuccess<T>(TioResultTransformer<R, E, T> builder) =>
      TioHttpFailure<T, E>(error: error, response: response);

  // @override
  // List<Object?> get props => [error];
}
