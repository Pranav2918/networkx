import 'package:equatable/equatable.dart';
import 'package:networkx/src/data/models/post_model.dart';

abstract class PostStates extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostStates {}

class PostLoading extends PostStates {}

class PostLoaded extends PostStates {
  PostLoaded({required this.posts});

  final Posts posts;

  @override
  List<Object?> get props => [posts];
}

class PostFailed extends PostStates {
  PostFailed({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
