import 'package:flutter/widgets.dart';
import 'package:networkx/src/data/models/post_model.dart';
import 'package:networkx/src/data/models/product_model.dart';
import 'package:networkx/src/data/models/user_model.dart';
import 'package:networkx/src/data/network/dio_client.dart';
import 'package:networkx/src/domain/repositories/app_repositories.dart';

class AppRepositoryImpl implements AppRepositories {
  AppRepositoryImpl({required this.dioClient});
  final DioClient dioClient;

  @override
  Future<Posts> fetchPosts() async {
    const endpoint = 'getContent/Posts';

    const headers = {'x-access-token': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjZmZDIyOTcxOTg2YzUyYzNmODQ5ODMyIiwiZW1haWwiOiJ0aG9yMUB5b3BtYWlsLmNvbSIsInJvbGUiOlsiQ2VydGlmaWVkVXNlciJdLCJmaXJzdE5hbWUiOiJUaGUiLCJsYXN0TmFtZSI6IlRob3IiLCJpc0RlZmF1bHRJbWFnZSI6ZmFsc2UsImRlZmF1bHRJbWFnZVBhdGgiOiIiLCJpc1JlZ2lzdHJhdGlvbkNvbXBsZXRlIjpmYWxzZSwiaWF0IjoxNzU5OTE2OTMxLCJleHAiOjE3NjI1MDg5MzF9.QsH2HmIAdowKYpORh87nPyakHTxUpuF2_kKCnitbHR4'};

    const body = {
      'radius': 10,
      'pageSize': 5,
      'page': 0,
      'longitude': 6.9666717,
      'latitude': 51.3260567,
    };

    final response = await dioClient.post(
      endpoint,
      data: body,
      headers: headers,
    );

    final data = response.data;
    debugPrint('DATA :: $data');
    return Posts.fromJson(data);
  }

  @override
  Future<ProductsModel> fetchProducts() async {
    const endpoint = 'products';
    final response = await dioClient.get(endpoint);

    final data = response.data;
    return ProductsModel.fromJson(data);
  }

  @override
  Future<User> login(String email, String password) async {
    const endpoint = 'login';
    final body = {'email': email, 'password': password, 'isMobile': true};

    final response = await dioClient.post(endpoint, data: body);
    final data = response.data;
    return User.fromJson(data);
  }
}
