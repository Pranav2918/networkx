import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/domain/repositories/app_repositories.dart';
import 'package:networkx/src/presentation/features/products/bloc/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit({required this.appRepository}) : super(ProductInitial());

  final AppRepositories appRepository;

  Future<void> fetchAllProducts() async {
    emit(ProductLoading());
    try {
      final productData = await appRepository.fetchProducts();
      emit(ProductLoaded(products: productData));
    } catch (e) {
      emit(ProductFailed(errorMessage: e.toString()));
    }
  }
}
