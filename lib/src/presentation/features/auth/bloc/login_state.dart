import 'package:equatable/equatable.dart';
import 'package:networkx/src/data/models/user_model.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequestInitial extends LoginState {}

class LoginRequestLoading extends LoginState {}

class LoginRequestApproved extends LoginState {
  LoginRequestApproved({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

class LoginRequestRejected extends LoginState {
  LoginRequestRejected({required this.errorMessage});

  final String errorMessage;
  @override
  List<Object?> get props => [errorMessage];
}
