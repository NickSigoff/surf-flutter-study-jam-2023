// import 'package:dio/dio.dart';
//
// abstract class ApiClient {
//   static ApiClient instance = ApiClient(Dio(
//     BaseOptions(contentType: "application/json"),
//   ));
//
//   factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;
//
//   Future<void> getHomePageInfo();
//
//   Future<void> getCartPageInfo();
//
//   Future<void> getDetailPageInfo();
// }