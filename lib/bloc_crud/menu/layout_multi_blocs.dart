import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_bloc.dart';
import 'package:bloc2/bloc_crud/bloc_builder/blocs/post_event.dart';
import 'package:bloc2/bloc_crud/bloc_consumer/blocs/post_bloc.dart';
import 'package:bloc2/bloc_crud/bloc_consumer/blocs/post_event.dart';
import 'package:bloc2/bloc_crud/bloc_consumer/repositories/post_repository.dart';
import 'package:bloc2/bloc_crud/bloc_listener/blocs/post_bloc.dart';
import 'package:bloc2/bloc_crud/bloc_listener/blocs/post_event.dart';
import 'package:bloc2/bloc_crud/menu/GlobalParams.dart';
// import 'package:bloc2/bloc_crud/bloc_listener/view/post_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LayoutMultiBlocs extends StatelessWidget {
  final PostConsumerRepository consumerRepository = PostConsumerRepository();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostListenerBloc()..add(FetchListenerPosts()),
          // child: PostView(),
        ),
        BlocProvider(
          create:
              (_) =>
                  PostConsumerBloc(consumerRepository)
                    ..add(FetchConsumerPosts()),
          // child: PostView(),
        ),
        BlocProvider(
          create: (context) => PostBuilderBloc()..add(FetchBuilderPosts()),
          // child: PostView(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter BLoC builder CRUD',
        debugShowCheckedModeBanner: false,
        routes: Globalparams.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          // primarySwatch: Colors.red,
        ),
        initialRoute: '/',
        // home: Home(),
      ),
    );
  }
}
