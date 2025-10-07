import 'package:flutter/widgets.dart';
import 'package:networkx/src/data/models/post_model.dart';
import 'package:networkx/src/data/network/dio_client.dart';

class AppRepository {
  AppRepository({required this.dioClient});

  final DioClient dioClient;

  //FETCH POSTS
  Future<Posts> fetchPosts() async {
    const endpoint = 'getContent/Posts';

    const headers = {
      'x-access-token':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiNjZmZDIyOTcxOTg2YzUyYzNmODQ5ODMyIiwiZW1haWwiOiJ0aG9yMUB5b3BtYWlsLmNvbSIsInJvbGUiOlsiQ2VydGlmaWVkVXNlciJdLCJmaXJzdE5hbWUiOiJUaGUiLCJsYXN0TmFtZSI6IlRob3IiLCJpc0RlZmF1bHRJbWFnZSI6ZmFsc2UsImRlZmF1bHRJbWFnZVBhdGgiOiIiLCJpc1JlZ2lzdHJhdGlvbkNvbXBsZXRlIjpmYWxzZSwiaWF0IjoxNzU5ODEzOTUxLCJleHAiOjE3NjI0MDU5NTF9.wyHkMaG4BjY2Lmc8JYOh3rlKHNxiyvAdbJoFG3133Yo',
    };

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
}
