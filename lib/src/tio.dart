import 'package:dio/dio.dart';

import 'factory_config.dart';
import 'responses/response.dart';
import 'tio_mixin.dart';
import 'tio_transform_mixin.dart';
import 'typedefs.dart';

class Tio<E> with TioMixin<E>, TioTransformMixin<E> {
  const Tio({required this.dio, required this.factoryConfig});

  factory Tio.withInterceptors({
    required Dio dio,
    required TioFactoryConfig<E> factoryConfig,
    List<TioInterceptorBuilder<E>> builders = const [],
  }) {
    final tio = Tio(dio: dio, factoryConfig: factoryConfig);
    for (final builder in builders) {
      dio.interceptors.add(builder(tio));
    }
    return tio;
  }

  final Dio dio;

  @override
  final TioFactoryConfig<E> factoryConfig;

  @override
  Future<TioResponse<R, E>> request<R, D>(
    String path,
    TioResponseTransformer<R, E, D> transformer, {
    Object? data,
    JsonMap? queryParameters,
    CancelToken? cancelToken,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await dio
          .request<D>(
            path,
            data: data,
            queryParameters: queryParameters,
            cancelToken: cancelToken,
            options: checkOptions(options: options),
            onSendProgress: onSendProgress,
            onReceiveProgress: onReceiveProgress,
          )
          .then(transformer);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return TioResponse<R, E>.failure(
          error: transformError(e.response!),
          response: e.response,
        );
      }
      rethrow;
    }
  }

  /// Adds a method and responseType to the [Options] if they are absent.
  static Options checkOptions({
    Options? options,
    String? method,
    ResponseType? responseType,
  }) =>
      (options ?? Options())
          .copyWith(method: method, responseType: responseType);
}
