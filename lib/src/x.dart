import 'package:dio/dio.dart';

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
  Options toOptions() => Options(
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
