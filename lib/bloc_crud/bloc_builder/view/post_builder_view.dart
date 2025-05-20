import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_bloc.dart';
import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_event.dart';
import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_state.dart';
import 'package:bloc2/bloc_crud/models/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostBuilderView extends StatelessWidget {
  final userIdController = TextEditingController();
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  void _showFormDialog(BuildContext context, {Post? post}) {
    if (post != null) {
      userIdController.text = post.userId.toString();
      titleController.text = post.title;
      bodyController.text = post.body;
    } else {
      userIdController.clear();
      titleController.clear();
      bodyController.clear();
    }

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(post == null ? 'Ajouter' : 'Modifier'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: userIdController,
                  decoration: InputDecoration(labelText: 'userId'),
                ),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: bodyController,
                  decoration: InputDecoration(labelText: 'Body'),
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  final userId = userIdController.text;
                  final title = titleController.text;
                  final body = bodyController.text;
                  if (post == null) {
                    context.read<PostBuilderBloc>().add(
                      AddPost(
                        Post(
                          id: 0,
                          userId: int.parse(userId),
                          title: title,
                          body: body,
                        ),
                      ),
                    );
                  } else {
                    context.read<PostBuilderBloc>().add(
                      UpdatePost(
                        Post(
                          id: post.id,
                          userId: int.parse(userId),
                          title: title,
                          body: body,
                        ),
                      ),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(post == null ? 'Créer' : 'Mettre à jour'),
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
                context.read<PostBuilderBloc>().add(DeletePost(id));
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('CRUD avec BLoC builder')),
      body: BlocListener<PostBuilderBloc, PostState>(
        listener: (context, state) {
          if (state is PostError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          } else if (state is PostActionSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Succès de l\'action !')));
          }
        },
        child: BlocBuilder<PostBuilderBloc, PostState>(
          builder: (context, state) {
            if (state is PostLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PostLoaded) {
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text('${post}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () => _showFormDialog(context, post: post),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            confirmeDelete(context, post.id);
                          },
                          //  => context.read<PostBuilderBloc>().add(
                          //   DeletePost(post.id),
                          // )
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: Text('Aucune donnée.'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFormDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }
}
