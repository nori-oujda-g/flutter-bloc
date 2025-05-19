import 'package:bloc2/bloc_crud/bloc_listener/blocs/post_bloc.dart';
import 'package:bloc2/bloc_crud/bloc_listener/blocs/post_event.dart';
import 'package:bloc2/bloc_crud/bloc_listener/view/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutListener extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BLoC listener CRUD',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => PostBloc()..add(FetchPosts()),
        child: PostView(),
      ),
    );
  }
}
