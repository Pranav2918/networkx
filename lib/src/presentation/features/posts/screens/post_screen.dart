import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/data/models/post_model.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_bloc.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_events.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_states.dart';
import 'package:networkx/src/presentation/widgets/loading_indicator.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostBloc>().add(FetchPosts());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Posts')),
    body: BlocBuilder<PostBloc, PostStates>(
      builder: (context, state) {
        if (state is PostInitial || state is PostLoading) {
          return const LoadingIndicator();
        }
        if (state is PostFailed) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        }
        if (state is PostLoaded) {
          return PostList(posts: state.posts.postData);
        }
        return const SizedBox.shrink();
      },
    ),
  );
}

class PostList extends StatelessWidget {
  const PostList({required this.posts, super.key});
  final List<PostData> posts;

  @override
  Widget build(BuildContext context) => ListView.builder(
    key: UniqueKey(),
    itemCount: posts.length,
    itemBuilder: (context, index) => ListTile(
      title: Text(posts[index].id),
      subtitle: Text(posts[index].postDescription),
    ),
  );
}
