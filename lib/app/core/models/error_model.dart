import '../../network/exceptions.dart';

class ErrorModel {
  ErrorModel({this.code, this.errorMessage});

  ErrorModel.fromException(AppException exception) {
    code = exception.code;
    errorMessage = exception.message;
  }

  ApiErrorCode? code;
  String? errorMessage;
}
