## 2.4.0
- Update dependencies

## 2.3.0
- Update example
- Added Future.maybeUnwrap method
- Added TioResponse.maybeResult and maybeError getters

## 2.2.0
- Added TioResponse.requireError getter
- Added FutureX.unwrap method

## 2.1.0
- Added TioAuthInterceptor.buildAccessToken for transforming before sending

## 2.0.0
- Added TioResponse.map and when methods similar to freezed map/when
- **BREAKING**: TioResponse now is not exhausted. Use map/when methods
- TioResponse splitted for base TioResponse and TioHttpResponse with dio.Response response property
- Empty factory removed, factories now is typedefs

## 1.1.0
- added Future<TioResponse>.map extension method

## 1.0.0+2
- update README.md

## 1.0.0+1
- fix code style
- update dependencies

## 1.0.0
- release
- 'package:tio/tio.dart' not does not export dio
- 'package:tio/tio.dart' now exports JsonMap typedef
- rewrite tests
- auth interceptor sync refresh feature

## 0.8.0
- pre-release
- Some refactoring
- TioFactoryConfig now receiving factories in first positional argument, instead of named
- TioService renamed to TioApi and hot additional functionality
- TioApi now mirrors common request methods with applying TioApi.path property as prefix of path
- Reworded error system. Now Tio using DioException as base error.

## 0.7.1
- fix static analysis

## 0.7.0
- update README.md
- added RefreshableAuthInterceptor.onFailureRefresh
- added TioResponse.map map
- fix TioExceptions thrown from interceptors
- refactor TioResponse.withSuccess method

## 0.6.1
- fix web compability

## 0.6.0
- remove Response.contentType extension getter for web compability

## 0.5.0
- update README.md
- changes in error factories

## 0.4.0
- update README.md
- update analysis_options.yaml
- more informative TioError error
- Tio.withInterceptors now factory constructor
- added head method
- added some tests

## 0.3.0
- update README.md
- update pubspec.yaml topics
- added ResponseOptions.toOptions extension method
- added Dio.restart extension method
- added github workflows
- fix code styles

## 0.2.0
- update README.md
- update pubspec.yaml topics
- fix tests
- added List.check<T> and List.castChecked<T> extension methods
- added Response.contentType extension getter

## 0.1.1
- Update README.md
- Add LICENSE
- Remove unused private TioException constructor
- Wildcard unused variable

## 0.1.0
- Initial version.
