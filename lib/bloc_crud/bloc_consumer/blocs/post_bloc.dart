// blocs/post_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository repository;

  PostBloc(this.repository) : super(PostInitial()) {
    on<LoadPosts>((event, emit) async {
      emit(PostLoading());
      try {
        final posts = await repository.fetchPosts();
        emit(PostLoaded(posts));
      } catch (_) {
        emit(PostError("Erreur de chargement"));
      }
    });

    on<AddPost>((event, emit) async {
      if (state is PostLoaded) {
        try {
          await repository.createPost(event.post);
          add(LoadPosts());
        } catch (e) {
          emit(PostError("Erreur d'ajout: $e "));
        }
      }
    });
    on<UpdatePost>((event, emit) async {
      if (state is PostLoaded) {
        try {
          await repository.updatePost(event.post);
          add(LoadPosts());
        } catch (e) {
          emit(PostError("Erreur de mise à jour $e "));
        }
      }
    });

    on<DeletePost>((event, emit) async {
      if (state is PostLoaded) {
        try {
          await repository.deletePost(event.id);
          add(LoadPosts());
        } catch (e) {
          emit(PostError("Erreur de suppression: $e "));
        }
      }
    });
  }
}
