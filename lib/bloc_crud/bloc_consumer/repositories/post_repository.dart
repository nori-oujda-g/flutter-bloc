// repositories/post_repository.dart
import 'dart:convert';

import 'package:bloc2/bloc_crud/env.dart';
import 'package:bloc2/bloc_crud/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepository {
  Future<List<Post>> fetchPosts() async {
    final response = await http.get(Uri.parse(baseUrl));
    final data = json.decode(response.body) as List;
    return data.map((e) => Post.fromJson(e)).toList();
  }

  Future<Post> createPost(Post post) async {
    Post post0 = Post(
      id: 0,
      userId: post.userId,
      title: post.title,
      body: post.body,
    );
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(post0.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return Post.fromJson(json.decode(response.body));
  }

  Future<Post> updatePost(Post post) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${post.id}'),
      body: json.encode(post.toJson()),
      headers: {'Content-Type': 'application/json'},
    );
    return Post.fromJson(json.decode(response.body));
  }

  Future<Post> enythingPost(Post post) async {
    return post;
  }

  Future<void> deletePost(int id) async {
    await http.delete(Uri.parse('$baseUrl/$id'));
  }
}
