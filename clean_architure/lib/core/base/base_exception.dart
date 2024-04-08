class BaseException implements Exception {
  final String? message;
  final String? code;

  BaseException({this.message, this.code});
}
