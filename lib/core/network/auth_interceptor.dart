import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

//
// class AuthInterceptor extends Interceptor {
//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     // Add your API key & other stuff to the headers.
//     // final creds =
//     //     await GetIt.instance.get<Auth0>().credentialsManager.credentials();
//     // options.headers.addAll(
//     //   {"Authorization": "Bearer ${creds.accessToken}"},
//     // );
//     handler.next(options);
//   }
//
//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     return handler.reject(DioException(
//       requestOptions: err.requestOptions,
//       error: err.response,
//     ));
//   }
// }
