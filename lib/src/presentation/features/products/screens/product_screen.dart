import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/data/models/product_model.dart';
import 'package:networkx/src/presentation/features/products/bloc/product_cubit.dart';
import 'package:networkx/src/presentation/features/products/bloc/product_state.dart';
import 'package:networkx/src/presentation/widgets/loading_indicator.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().fetchAllProducts();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Products')),
    body: BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductInitial || state is ProductLoading) {
          return const LoadingIndicator();
        }
        if (state is ProductFailed) {
          return Center(child: Text('ERR: ${state.errorMessage}'));
        }
        if (state is ProductLoaded) {
          return ProductList(products: state.products.products);
        }
        return const SizedBox.shrink();
      },
    ),
  );
}

class ProductList extends StatelessWidget {
  const ProductList({required this.products, super.key});
  final List<Products> products;

  @override
  Widget build(BuildContext context) => ListView.builder(
    itemCount: products.length,
    itemBuilder: (context, index) {
      final product = products[index];
      return ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color.fromARGB(255, 214, 129, 138),
          child: Center(child: Text(product.id.toString())),
        ),
        title: Text(product.title),
        subtitle: Text(product.description),
      );
    },
  );
}
