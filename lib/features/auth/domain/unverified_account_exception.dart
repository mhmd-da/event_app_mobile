class UnverifiedAccountException implements Exception {
  final String message;
  final int? userId;
  UnverifiedAccountException(this.message, {this.userId});
  @override
  String toString() => message;
}
