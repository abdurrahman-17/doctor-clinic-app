import 'dart:convert';
import 'dart:developer';
import 'dart:io';


import 'package:dio/dio.dart';

import '../../data_constants.dart';
// import 'package:ezyCartSupport/data/util/data_constants.dart';

class ApiBaseHelper {
  static final String url = DataConstants.LIVE_BASE_URL;
  static BaseOptions opts = BaseOptions(
    baseUrl: url,
    responseType: ResponseType.json,
    connectTimeout: 60 * 1000,
    receiveTimeout: 60 * 1000,
    sendTimeout: 60 * 1000,
  );

  static Dio createDio() {
    return Dio(opts);
  }

  static Dio? addInterceptors(Dio dio) {
    return dio
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        var customHeaders = {
          'content-type': 'application/json',
          'Accept': 'application/json',
          'refreshToken': 'refreshToken',
          'uid': 'uid',
          // other headers
        };
        options.headers.addAll(customHeaders);
        // Do something before request is sent
        return handler.next(options); //continue
        //return requestInterceptor(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`

        ////New code
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      }));
  }

  static dynamic requestInterceptor(RequestOptions options) async {
    // Get your JWT token

    const token = '';
    //options.headers.addAll({"Content-Type": "application/json"});
    // options.headers.addAll({"Accept": "application/json"});
    options.headers.addAll({"refreshToken": "refreshToken"});
    options.headers.addAll({"uid": "uid"});
    //options.headers.addAll({"Authorization": "Bearer: $token"});
    return options;
  }

  static Dio addInterceptorsCart(Dio dio, String token) {
    // return dio
    //   ..interceptors.add(
    //     InterceptorsWrapper(
    //         onRequest: (RequestOptions options) => requestInterceptorCart(options,token),
    //         onError: (DioError e) async {
    //           return e.response;
    //         }),
    //   );
    return dio
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        // return handler.next(options); //continue
        return requestInterceptor(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      }));
  }


  //////Header with Orgin
  static Dio addInterceptorsWithOrigin(Dio dio, String token) {
    // return dio
    //   ..interceptors.add(
    //     InterceptorsWrapper(
    //         onRequest: (RequestOptions options) => requestInterceptorWithOrigin(options,token),
    //         onError: (DioError e) async {
    //           return e.response;
    //         }),
    //   );

    return dio
      ..interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
        // Do something before request is sent
        // return handler.next(options); //continue
        return requestInterceptor(options); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onResponse: (response, handler) {
        // Do something with response data
        return handler.next(response); // continue
        // If you want to reject the request with a error message,
        // you can reject a `DioError` object eg: return `dio.reject(dioError)`
      }, onError: (DioError e, handler) {
        // Do something with response error
        return handler.next(e); //continue
        // If you want to resolve the request with some custom data，
        // you can resolve a `Response` object eg: return `dio.resolve(response)`.
      }));
  }


  static final dio = createDio();
  static final baseAPI = addInterceptors(dio);

  Future<Response?> getHTTP(String url) async {

    print('========= REQUEST =========');
    print('$url');
    try {
      Response response = await baseAPI!.get(url);
      print('========= RESPONSE =========');
      print('========= $url =========');
      print(response.data);
      print('========= RESPONSE-END =========');
    //  writeContent('API_BASE_HELPER - getHTTP \n  $url \n ${response.data}' );

      return response;
    } on DioError catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<Response?> getHTTPWithBearerToken(String url, String token) async {
    print('========= REQUEST =========');
    print('$url');
    print('$token');
    try {
      final baseAPI = addInterceptorsCart(dio, token);
      print('========= REQUEST1 =========');
      Response response = await baseAPI.get(
        url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$token',
        }),
      );
      print('========= RESPONSE =========');
      print(response.data);
    //  writeContent('API_BASE_HELPER - getHTTPWithBearerToken \n  $url \n ${response.data}' );

      /* Response response = await baseAPI.post(url, data: data);*/
      return response;
    } on DioError catch (e) {
      print(e);
      print('mmmm error');
      // Handle error
    }
  }

  Future<Response?> postHTTPWithBearerToken(
      String url, dynamic data, String token) async {
    try {
      log('postHTTPWithBearerToken  '+token);

      final baseAPI = addInterceptorsWithOrigin(dio, token);
      Response response = await baseAPI.post(
        url,
        // options: Options(headers: {
        //   HttpHeaders.contentTypeHeader: "application/json",
        // }
        options: Options(

            //   headers: {
            //   HttpHeaders.contentTypeHeader: "application/json",
            //   HttpHeaders.authorizationHeader: 'Bearer $token',
            // }

            //   headers: {
            // "Content-Type": "application/json",
            // 'Authorization': 'Bearer $token',
            //
            // },

            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'origin': 'ezycart',
              'Authorization': 'Bearer $token',
            }),
        data: jsonEncode(data),
      );
     // writeContent('API_BASE_HELPER - postHTTPWithBearerToken\n$url \n$token\n${response.data}' );

      /* Response response = await baseAPI.post(url, data: data);*/
      return response;
    } on DioError catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<Response?> postHTTP(String url, dynamic data) async {
    try {
      Response response = await baseAPI!.post(
        url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(data),
      );

      /* Response response = await baseAPI.post(url, data: data);*/
      return response;
    } on DioError catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<Response?> putHTTP(String url, dynamic data) async {
    try {
      print('--->>>Path--${url}');
      print('--->>>data--${data}');
      Response response = await baseAPI!.put(url, data: data);
      return response;
    } on DioError catch (e) {
      print('error-->>$e');
    }
  }

  Future<Response?> putHTTPWithBearerToken(
      String url, dynamic data, String token) async {
    try {
      final baseAPI = addInterceptorsWithOrigin(dio, token);
      Response response = await baseAPI.put(
        url,
        // options: Options(headers: {
        //   HttpHeaders.contentTypeHeader: "application/json",
        // }
        options: Options(

            //   headers: {
            //   HttpHeaders.contentTypeHeader: "application/json",
            //   HttpHeaders.authorizationHeader: 'Bearer $token',
            // }

            //   headers: {
            // "Content-Type": "application/json",
            // 'Authorization': 'Bearer $token',
            //
            // },

            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'origin': 'ezycart',
              'Authorization': 'Bearer $token',
            }),
        data: jsonEncode(data),
      );

      /* Response response = await baseAPI.post(url, data: data);*/
      return response;
    } on DioError catch (e) {
      print(e);
      // Handle error
    }
  }

  Future<Response?> deleteHTTP(String url) async {
    try {
      Response response = await baseAPI!.delete(url);
      return response;
    } on DioError catch (e) {
      // Handle error
    }
  }
}
