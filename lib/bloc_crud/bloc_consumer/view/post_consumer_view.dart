// screens/post_screen.dart
import 'package:bloc2/bloc_crud/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/post_bloc.dart';
import '../blocs/post_event.dart';
import '../blocs/post_state.dart';

enum Operation { ADD, UPDATE }

class PostConsumerView extends StatelessWidget {
  static final Post post0 = Post(id: 0, userId: 0, body: '', title: '');
  Post setPost = post0;
  final String title1 = 'zzz';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("un crud avec bloc consumer ")),
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<PostConsumerBloc, PostState>(
              listener: (context, state) {
                if (state is PostError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                if (state is PostLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is PostLoaded) {
                  return ListView.builder(
                    itemCount: state.posts.length,
                    itemBuilder: (_, index) {
                      final post = state.posts[index];
                      return ListTile(
                        title: Text(post.title),
                        subtitle: Text('${post}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.update),
                              onPressed: () {
                                setPost = Post(
                                  id: post.id,
                                  userId: post.userId,
                                  title: post.title,
                                  body: post.body,
                                );
                                _showAddPostDialog(context, Operation.UPDATE);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                confirmeDelete(context, post.id);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is PostError) {
                  return Center(child: Text(state.message));
                }
                return const Center(child: Text("Aucun post"));
              },
            ),
          ),
          Container(child: Text('selected post : $setPost ')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setPost = post0;
          _showAddPostDialog(context, Operation.ADD);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddPostDialog(BuildContext context, Operation operation) {
    TextEditingController userIdController = TextEditingController(
      text: setPost.userId.toString(),
    );
    TextEditingController titleController = TextEditingController(
      text: setPost.title,
    );
    TextEditingController bodyController = TextEditingController(
      text: setPost.body,
    );

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(
              operation == Operation.ADD
                  ? 'Ajouter un post'
                  : operation == Operation.UPDATE
                  ? 'mise à jour d un post'
                  : '---',
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userIdController,
                  decoration: const InputDecoration(labelText: 'userId'),
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Titre'),
                ),
                TextField(
                  controller: bodyController,
                  decoration: const InputDecoration(labelText: 'Contenu'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final post = Post(
                    id: setPost.id,
                    // userId: 0,
                    userId: int.parse(userIdController.text),
                    title: titleController.text,
                    body: bodyController.text,
                  );
                  print('commit to post = $post');
                  context.read<PostConsumerBloc>().add(
                    operation == Operation.ADD
                        ? AddPost(post)
                        : operation == Operation.UPDATE
                        ? UpdatePost(post)
                        : EnythingPost(post),
                  );
                  titleController.clear();
                  bodyController.clear();
                  userIdController.clear();
                  Navigator.pop(context);
                },
                child: Text(
                  operation == Operation.ADD
                      ? 'Ajouter'
                      : operation == Operation.UPDATE
                      ? 'mise à jour'
                      : '---',
                ),
              ),
            ],
          ),
    );
  }

  void confirmeDelete(BuildContext context, int id) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Êtes-vous sûr de vouloir supprimer ?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Annuler'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            ElevatedButton(
              child: const Text('Confirmer'),
              onPressed: () {
                context.read<PostConsumerBloc>().add(DeletePost(id));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
