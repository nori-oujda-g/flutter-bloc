import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/post_bloc.dart';
import 'blocs/post_event.dart';
import 'repositories/post_repository.dart';
import 'view/post_view.dart';

class LayouteConcumer extends StatelessWidget {
  final PostRepository repository = PostRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'crud bloc consumer',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PostBloc(repository)..add(LoadPosts()),
        child: PostView(),
      ),
    );
  }
}
