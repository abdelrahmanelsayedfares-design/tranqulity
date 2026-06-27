import 'package:dio/dio.dart';
import '../../views/auth/login.dart';
import 'cash_helper.dart';
import 'helper_methods.dart';

enum DataState { loading, failed, success }

class DioHelper {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://tranquility.growfet.com/',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );

  static Future<CustomResponse> sendData(
      String path, {
        dynamic data,
        bool isFormData = false, // لو حابب تبعت form-data بدل json
      }) async {
    try {
      if (CacheHelper.token.isNotEmpty) {
        _dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.token}';
      }

      final response = await _dio.post(
        path,
        data: isFormData && data != null ? FormData.fromMap(data) : data,
      );

      return CustomResponse(isSuccess: true, data: response.data);

    } on DioException catch (e) {
      // لو 401 اعمل logout وروح login
      if (e.response?.statusCode == 401) {
        await CacheHelper.logout();
        goTo(LoginView(), canPop: false);
      }

      return CustomResponse(
        isSuccess: false,
        data: e.response?.data,
      );
    } catch (e) {
      // لأي error غير Dio
      return CustomResponse(
        isSuccess: false,
        data: {'message': e.toString()},
      );
    }
  }
  static Future<CustomResponse> getData(
      String path, {
        Map<String, dynamic>? queryParameters,
      }) async {
    try {
      if (CacheHelper.token.isNotEmpty) {
        _dio.options.headers['Authorization'] = 'Bearer ${CacheHelper.token}';
      }

      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
      );

      return CustomResponse(isSuccess: true, data: response.data);

    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await CacheHelper.logout();
        goTo(LoginView(), canPop: false);
      }

      return CustomResponse(
        isSuccess: false,
        data: e.response?.data,
      );
    } catch (e) {
      return CustomResponse(
        isSuccess: false,
        data: {'message': e.toString()},
      );
    }
  }
  static Future<CustomResponse> putData(
      String path, {
        dynamic data,
        bool isFormData = false,
      }) async {
    try {
      if (CacheHelper.token.isNotEmpty) {
        _dio.options.headers['Authorization'] =
        'Bearer ${CacheHelper.token}';
      }

      final response = await _dio.put(
        path,
        data: isFormData && data != null
            ? FormData.fromMap(data)
            : data,
      );

      return CustomResponse(
        isSuccess: true,
        data: response.data,
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        await CacheHelper.logout();
        goTo(LoginView(), canPop: false);
      }

      return CustomResponse(
        isSuccess: false,
        data: e.response?.data,
      );
    } catch (e) {
      return CustomResponse(
        isSuccess: false,
        data: {'message': e.toString()},
      );
    }
  }
}

class CustomResponse {
  final bool isSuccess;
  final dynamic data;
  String? message;

  CustomResponse({required this.isSuccess, this.data}) {
    if (data is Map) {
      message = data['message']?.toString();

      message ??= data['data']?['message']?.toString();

      message ??= 'Something went wrong';
    } else if (data is String) {
      message = data;
    }
  }
}
