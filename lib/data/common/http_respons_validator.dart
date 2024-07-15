import 'package:dio/dio.dart';
import 'package:nike/common/exception.dart';

mixin HttpResponsValidator {
  validateRespons(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }
}
