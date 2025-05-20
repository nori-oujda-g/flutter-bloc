import 'dart:convert';

import 'package:bloc2/bloc_crud/env.dart';
import 'package:bloc2/bloc_crud/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'post_event.dart';
import 'post_state.dart';

class PostBuilderBloc extends Bloc<PostEvent, PostState> {
  PostBuilderBloc() : super(PostInitial()) {
    on<FetchBuilderPosts>(_onFetchBuilderPosts);
    on<AddPost>(_onAddPost);
    on<UpdatePost>(_onUpdatePost);
    on<DeletePost>(_onDeletePost);
  }

  Future<void> _onFetchBuilderPosts(
    FetchBuilderPosts event,
    Emitter<PostState> emit,
  ) async {
    emit(PostLoading());
    try {
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final posts = data.map((json) => Post.fromJson(json)).toList();
        emit(PostLoaded(posts));
      } else {
        emit(PostError('Erreur lors du chargement'));
      }
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onAddPost(AddPost event, Emitter<PostState> emit) async {
    try {
      await http.post(
        Uri.parse(baseUrl),
        body: json.encode(event.post.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      emit(PostActionSuccess());
      add(FetchBuilderPosts());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onUpdatePost(UpdatePost event, Emitter<PostState> emit) async {
    try {
      await http.put(
        Uri.parse('$baseUrl/${event.post.id}'),
        body: json.encode(event.post.toJson()),
        headers: {'Content-Type': 'application/json'},
      );
      emit(PostActionSuccess());
      add(FetchBuilderPosts());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }

  Future<void> _onDeletePost(DeletePost event, Emitter<PostState> emit) async {
    try {
      await http.delete(Uri.parse('$baseUrl/${event.id}'));
      emit(PostActionSuccess());
      add(FetchBuilderPosts());
    } catch (e) {
      emit(PostError(e.toString()));
    }
  }
}
