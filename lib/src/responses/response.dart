import 'package:dio/dio.dart';

import '../typedefs.dart';

T? _null<T>(_) => null;

T _self<T>(T o) => o;

sealed class TioResponse<R, E> {
  const TioResponse._({this.response});

  const factory TioResponse.success({
    required R value,
    Response<dynamic>? response,
  }) = TioSuccess;

  const factory TioResponse.failure({
    required E error,
    Response<dynamic>? response,
  }) = TioFailure;

  final Response<dynamic>? response;

  TioResponse<T, E> withSuccess<T>(TioResultTransformer<R, E, T> builder);

  T map<T>({
    required T Function(TioSuccess<R, E> success) success,
    required T Function(TioFailure<R, E> failure) failure,
  }) =>
      switch (this) {
        final TioSuccess<R, E> value => success(value),
        final TioFailure<R, E> value => failure(value),
      };

  T when<T>({
    required T Function(R result) success,
    required T Function(E error) failure,
  }) =>
      switch (this) {
        final TioSuccess<R, E> value => success(value.value),
        final TioFailure<R, E> value => failure(value.error),
      };

  R? get valueOrNull => when(success: _self, failure: _null);

  E? get errorOrNull => when(success: _null, failure: _self);

  R get requireValue => when(
        success: _self,
        failure: (_) => throw StateError('Response is not succeed'),
      );

  E get requireError => when(
        success: (_) => throw StateError('Response is not failures'),
        failure: _self,
      );

  bool get hasValue => this is TioSuccess;

  bool get hasError => this is TioFailure;
}

class TioSuccess<R, E> extends TioResponse<R, E> {
  const TioSuccess({required this.value, super.response}) : super._();

  final R value;

  @override
  TioResponse<T, E> withSuccess<T>(TioResultTransformer<R, E, T> builder) =>
      TioResponse<T, E>.success(value: builder(this));
}

class TioFailure<R, E> extends TioResponse<R, E> {
  const TioFailure({required this.error, super.response}) : super._();

  final E error;

  @override
  TioResponse<T, E> withSuccess<T>(TioResultTransformer<R, E, T> builder) =>
      TioResponse<T, E>.failure(error: error);
}
