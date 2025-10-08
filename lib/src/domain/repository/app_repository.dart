import 'package:flutter/widgets.dart';
import 'package:networkx/src/data/models/post_model.dart';
import 'package:networkx/src/data/models/product_model.dart';
import 'package:networkx/src/data/models/user_model.dart';
import 'package:networkx/src/data/network/dio_client.dart';

class AppRepository {
  AppRepository({required this.dioClient});

  final DioClient dioClient;

  //FETCH POSTS
  Future<Posts> fetchPosts() async {
    const endpoint = 'getContent/Posts';

    const headers = {'x-access-token': 'auth-token'};

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

  //LOGIN
  Future<User> login(String email, String password) async {
    const endpoint = 'login';
    final body = {'email': email, 'password': password, 'isMobile': true};

    final response = await dioClient.post(endpoint, data: body);
    final data = response.data;
    return User.fromJson(data);
  }

  //PRODUCTS
  Future<ProductsModel> fetchProducts() async {
    const endpoint = 'products';
    final response = await dioClient.get(endpoint);

    final data = response.data;
    return ProductsModel.fromJson(data);
  }
}
