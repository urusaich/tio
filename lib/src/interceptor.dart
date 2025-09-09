import 'package:dio/dio.dart';

import 'tio.dart';

class TioInterceptor<E> extends Interceptor {
  const TioInterceptor({required this.tio});

  final Tio<E> tio;
}
