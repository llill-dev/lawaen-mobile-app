import '../../network/exceptions.dart';

class ErrorEntity {
  ErrorEntity({this.code, this.errorMessage});

  ErrorEntity.fromException(AppException exception) {
    code = exception.code;
    errorMessage = exception.message;
  }

  ApiErrorCode? code;
  String? errorMessage;
}
