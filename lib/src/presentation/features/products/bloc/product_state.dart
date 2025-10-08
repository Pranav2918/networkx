import 'package:equatable/equatable.dart';
import 'package:networkx/src/data/models/product_model.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  ProductLoaded({required this.products});

  final ProductsModel products;
  @override
  List<Object?> get props => [products];
}

class ProductFailed extends ProductState {
  ProductFailed({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
