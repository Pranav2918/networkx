import 'package:get_it/get_it.dart';
import 'package:networkx/src/data/network/dio_client.dart';
import 'package:networkx/src/domain/repository/app_repository.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_bloc.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_bloc.dart';
import 'package:networkx/src/presentation/features/products/bloc/product_cubit.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  sl.registerLazySingleton<DioClient>(() => DioClient());

  // Features - Posts
  sl.registerLazySingleton<AppRepository>(() => AppRepository(dioClient: sl()));

  // Blocs
  sl.registerFactory<PostBloc>(() => PostBloc(appRepository: sl()));
  sl.registerFactory<LoginBloc>(() => LoginBloc(appRepository: sl()));
  sl.registerFactory<ProductCubit>(() => ProductCubit(appRepository: sl()));
}
