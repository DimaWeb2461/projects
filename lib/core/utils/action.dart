import 'package:dartz/dartz.dart';

import '../api/errors.dart';
import '../api/firebase_client.dart';

Future<Either<AppError, void>> action({required Future Function() task}) async {
  try{
   await task.call();
    return right(null);
} on ExceptionWithMessage catch (error) {
    return Left(AppError(errorMessage: error.message));
  } catch(error) {
    return Left(AppError(errorMessage: error.toString()));
  }
}