import 'package:networkx/src/data/models/post_model.dart';
import 'package:networkx/src/data/models/product_model.dart';
import 'package:networkx/src/data/models/user_model.dart';

abstract class AppRepositories {

  Future<ProductsModel> fetchProducts();
  Future<Posts> fetchPosts();
  Future<User> login(String email, String password);
}