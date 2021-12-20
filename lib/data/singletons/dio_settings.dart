import 'package:dio/dio.dart';
import 'package:nabh_messenger/data/singletons/storage.dart';

class DioSettings {
  BaseOptions _dioBaseOptions = BaseOptions(
    baseUrl: '',
    connectTimeout: 35000,
    receiveTimeout: 33000,
    followRedirects: false,
    headers: {
      'Accept-Language': StorageRepository.getString('language', defValue: 'uz')
    },
    validateStatus: (status) {
      return status != null && status <= 500;
    },
  );

  void setBaseOptions({String? lang}) {
    _dioBaseOptions = BaseOptions(
      baseUrl: '',
      connectTimeout: 35000,
      receiveTimeout: 33000,
      headers: {'Accept-Language': lang},
      followRedirects: false,
      validateStatus: (status) {
        return status != null && status <= 500;
      },
    );
  }

  BaseOptions get dioBaseOptions => _dioBaseOptions;
}
