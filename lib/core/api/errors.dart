class AppError {
  final String errorMessage;

  const AppError({this.errorMessage = ''});
}

class ExceptionWithMessage implements Exception {
  final String message;

  ExceptionWithMessage(this.message);
}
