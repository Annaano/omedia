import 'package:dio/dio.dart';
import '../../core/constants/api_constants.dart';

class ObligationApiProvider {
  late final Dio _dio;

  static const String _baseUrl = ApiRouteConstants.baseUrl;

  ObligationApiProvider() {
    _dio = Dio(_createDioOptions());
    _setupInterceptors();
  }

  BaseOptions _createDioOptions() {
    return BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  Future<Response> fetchGoldObligations() async {
    try {
      final response = await _dio.get(ApiRouteConstants.obligationGold);

      if (response.data == null) {
        print('Warning: Response data is null');
      }
      return response;
    } catch (e) {
      print('Error in fetchGoldObligations: $e');
      rethrow;
    }
  }

  Future<Response> fetchOtherObligations() async {
    try {
      final response = await _dio.get(ApiRouteConstants.obligationOther);

      if (response.data == null) {
        print('Warning: Response data is null');
      }
      return response;
    } catch (e) {
      print('Error in fetchOtherObligations: $e');
      rethrow;
    }
  }

  Future<Response> fetchPdfTransactions() async {
    try {
      final response = await _dio.get(
        ApiRouteConstants.obligationTransaction,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {'Accept': 'application/pdf'},
        ),
      );

      if (response.data == null) {
        print('Warning: PDF response data is null');
      }
      return response;
    } catch (e) {
      print('Error in fetchPdfTransactions: $e');
      rethrow;
    }
  }

  Future<Response> fetchTransactionObligations() async {
    try {
      final response = await _dio.get(
        ApiRouteConstants.obligationTransaction,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.data == null) {
        print('Warning: Response data is null');
      }
      return response;
    } catch (e) {
      print('Error in fetchTransactionObligations: $e');
      rethrow;
    }
  }

  void dispose() {
    _dio.close();
  }
}
