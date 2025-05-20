import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_bloc.dart';
import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_event.dart';
import 'package:bloc2/bloc_crud/bloc_builder/view/post_builder_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutBuilder1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBuilderBloc()..add(FetchBuilderPosts()),
          // child: PostView(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter BLoC builder CRUD',
        debugShowCheckedModeBanner: false,
        home: PostBuilderView(),
        // home: BlocProvider(
        //   create: (context) => PostBuilderBloc()..add(FetchBuilderPosts()),
        // child: PostView(),
        // ),
      ),
    );
  }
}

//  @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter BLoC builder CRUD',
//       debugShowCheckedModeBanner: false,
//       home: BlocProvider(
//         create: (context) => PostBuilderBloc()..add(FetchBuilderPosts()),
//         child: PostView(),
//       ),
//     );
//   }
