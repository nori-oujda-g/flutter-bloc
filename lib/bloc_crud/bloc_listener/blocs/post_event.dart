import 'package:equatable/equatable.dart';

import '../../models/post.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchListenerPosts extends PostEvent {
  @override
  List<Object?> get props => [];
}

class AddPost extends PostEvent {
  final Post post;

  AddPost(this.post);
  @override
  List<Object?> get props => [post];
}

class UpdatePost extends PostEvent {
  final Post post;

  UpdatePost(this.post);
  @override
  List<Object?> get props => [post];
}

class DeletePost extends PostEvent {
  final int id;

  DeletePost(this.id);
  @override
  List<Object?> get props => [id];
}
