import 'package:dio/dio.dart';

import 'interceptor.dart';
import 'responses/response.dart';
import 'tio.dart';

typedef JsonMap = Map<String, dynamic>;
typedef TioJsonFactory<R> = R Function(JsonMap value);
typedef TioStringFactory<R> = R Function(String value);
typedef TioResponseTransformer<R, E, D> = TioResponse<R, E> Function(
  Response<D> resp,
);
typedef TioResultTransformer<R, E, T> = T Function(TioSuccess<R, E> current);
typedef TioInterceptorBuilder<E> = TioInterceptor<E> Function(Tio<E> tio);
