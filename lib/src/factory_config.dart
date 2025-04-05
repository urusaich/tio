import 'typedefs.dart';

class TioFactoryGroup<E> {
  const TioFactoryGroup({
    required this.string,
    required this.json,
  });

  final TioStringFactory<E> string;
  final TioJsonFactory<E> json;
}

class TioFactoryConfig<E> {
  const TioFactoryConfig({
    this.jsonFactories = const {},
    required this.errorStringFactory,
    required this.errorJsonFactory,
  });

  final Set<TioJsonFactory<dynamic>> jsonFactories;

  final TioStringFactory<E> errorStringFactory;
  final TioJsonFactory<E> errorJsonFactory;

  List<Type> get containsFactories =>
      jsonFactories.map(_genericTypeFactory).toList();

  TioJsonFactory<T>? get<T>() =>
      jsonFactories.whereType<TioJsonFactory<T>>().firstOrNull;

  bool contains<T>() => get<T>() != null;
}

Type _genericTypeFactory<T>(TioJsonFactory<T> factory) => T;
