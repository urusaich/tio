import 'package:dio/dio.dart';

import 'responses/response.dart';

/// Extension for [List]
extension ListX on List<dynamic> {
  /// Checks every item is type of T.
  bool check<T>() => every((item) => item is T);

  /// Cast self to `List<T>` if every item is type of T.
  /// Otherwise returns null.
  List<T>? castChecked<T>() => check<T>() ? List<T>.from(this) : null;
}

/// Extension for [RequestOptions]
extension RequestOptionsX on RequestOptions {
  /// Converts [RequestOptions] to [Options]
  Options toOptions() {
    return Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      preserveHeaderCase: preserveHeaderCase,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      persistentConnection: persistentConnection,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }
}

/// Extension for [Dio]
extension DioX on Dio {
  /// Restarts the http request
  Future<Response<T>> restart<T>(Response<T> originalResponse) {
    final requestOptions = originalResponse.requestOptions;
    return request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      cancelToken: requestOptions.cancelToken,
      options: requestOptions.toOptions(),
      onSendProgress: requestOptions.onSendProgress,
      onReceiveProgress: requestOptions.onReceiveProgress,
    );
  }
}

/// Extension for [Future]
extension FutureTioResponseX<R, E> on Future<TioResponse<R, E>> {
  /// Maps response
  Future<K> map<K>({
    required K Function(TioSuccess<R, E> success) success,
    required K Function(TioFailure<R, E> failure) failure,
  }) =>
      then((response) => response.map(success: success, failure: failure));

  /// Similar to [map] but passes [R] result or [E] error values to callbacks
  Future<K> when<K>({
    required K Function(R result) success,
    required K Function(E error) failure,
  }) =>
      then((response) => response.when(success: success, failure: failure));

  /// Returns result of the response
  Future<R> unwrap() => then((response) => response.requireResult);

  /// Returns result of the response or null if response is failure
  Future<R?> maybeUnwrap() => then((response) => response.maybeResult);
}
