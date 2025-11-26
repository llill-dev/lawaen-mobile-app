import '../../network/exceptions.dart';

class ErrorModel {
  String errorMessage;
  ApiErrorCode? code;

  ErrorModel({required this.errorMessage, this.code});

  factory ErrorModel.fromException(AppException exception) {
    return ErrorModel(errorMessage: exception.message, code: exception.code);
  }
}
