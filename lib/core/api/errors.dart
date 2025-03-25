
enum AppErrorType {
  api,
  notAuth,
  database,
  networkConnection,
}

class AppError {
  final String errorMessage;
  final AppErrorType type;

  const AppError({this.errorMessage = '', required this.type});
}

class ExceptionWithMessage implements Exception {
  final AppErrorType type;
  final String message;

  ExceptionWithMessage(this.message, this.type);
}
