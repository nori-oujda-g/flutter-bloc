// blocs/post_state.dart
import 'package:bloc2/bloc_crud/models/post.dart';
import 'package:equatable/equatable.dart';

abstract class PostState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostLoaded extends PostState {
  final List<Post> posts;
  PostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}

class PostError extends PostState {
  final String message;
  PostError(this.message);

  @override
  List<Object?> get props => [message];
}
