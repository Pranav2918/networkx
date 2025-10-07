import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/di/injector.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_bloc.dart';
import 'package:networkx/src/presentation/features/posts/screens/post_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies(); // Initialize DI
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (context) => sl<PostBloc>(),
    child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const PostScreen(),
    ),
  );
}
