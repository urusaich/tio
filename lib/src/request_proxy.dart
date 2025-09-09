import 'dart:typed_data';

import 'package:dio/dio.dart';

import 'interfaces/tio_base.dart';
import 'responses/response.dart';
import 'tio.dart';
import 'typedefs.dart';

class TioRequestProxy<T, E> {
  const TioRequestProxy(
    this.client,
    this.path, {
    required this.method,
    this.data,
    this.queryParameters,
    this.options,
    this.cancelToken,
    this.onSendProgress,
    this.onReceiveProgress,
  });

  final TioBase<E> client;
  final String path;
  final String method;
  final Object? data;
  final JsonMap? queryParameters;
  final Options? options;
  final CancelToken? cancelToken;
  final ProgressCallback? onSendProgress;
  final ProgressCallback? onReceiveProgress;

  Future<TioResponse<R, E>> _call<R, D>(
    ResponseType responseType,
    TioResponseTransformer<R, E, D> transformer,
  ) =>
      client.request<R, D>(
        path,
        transformer,
        data: data,
        queryParameters: queryParameters,
        options: Tio.checkOptions(
          options: options,
          method: method,
          responseType: responseType,
        ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

  Future<TioResponse<T, E>> one() =>
      _call<T, JsonMap>(ResponseType.json, client.transformOne);

  Future<TioResponse<List<T>, E>> many() =>
      _call<List<T>, List<dynamic>>(ResponseType.json, client.transformMany);

  Future<TioResponse<Uint8List, E>> bytes() =>
      _call(ResponseType.bytes, client.transformBytes);

  Future<TioResponse<ResponseBody, E>> stream() =>
      _call(ResponseType.stream, client.transformStream);

  Future<TioResponse<String, E>> string() =>
      _call(ResponseType.plain, client.transformString);

  Future<TioResponse<void, E>> empty() =>
      _call(ResponseType.plain, client.transformEmpty);
}
