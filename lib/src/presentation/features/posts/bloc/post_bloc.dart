import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:networkx/src/domain/repository/app_repository.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_events.dart';
import 'package:networkx/src/presentation/features/posts/bloc/post_states.dart';

class PostBloc extends Bloc<PostEvents, PostStates> {
  PostBloc({required this.appRepository}) : super(PostInitial()) {
    on<PostEvents>((event, emit) async {
      if (event is FetchPosts) {
        emit(PostLoading());
        try {
          final posts = await appRepository.fetchPosts();
          emit(PostLoaded(posts: posts));
        } catch (e) {
          emit(PostFailed(errorMessage: e.toString()));
        }
      }
    });
  }

  final AppRepository appRepository;
}
