import 'package:get_it/get_it.dart';
import 'package:networkx/src/data/network/dio_client.dart';
import 'package:networkx/src/data/repositories/app_repository_impl.dart';
import 'package:networkx/src/domain/repositories/app_repositories.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_bloc.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_bloc.dart';
import 'package:networkx/src/presentation/features/products/bloc/product_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Features - Posts
  sl.registerLazySingleton<AppRepositories>(() => AppRepositoryImpl(dioClient: sl()));

  // Blocs
  sl.registerFactory<PostBloc>(() => PostBloc(appRepository: sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(appRepository: sl()));
  sl.registerFactory<ProductCubit>(() => ProductCubit(appRepository: sl()));
}
