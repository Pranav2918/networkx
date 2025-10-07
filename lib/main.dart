import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/di/injector.dart';
import 'package:networkx/src/presentation/features/auth/bloc/login_bloc.dart';
import 'package:networkx/src/presentation/features/auth/screens/login_screen.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // Initialize DI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => sl<PostBloc>()),
      BlocProvider(create: (context) => sl<LoginBloc>()),
    ],
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(),
    ),
  );
}
