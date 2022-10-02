class ApiException implements Exception {
  final int code;
  final String? message;

  const ApiException({
    required this.code,
    this.message,
  });

  @override
  String toString() {
    return 'ApiException{code: $code, message: $message}';
  }
}
