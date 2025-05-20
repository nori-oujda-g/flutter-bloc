import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/post_bloc.dart';
import 'blocs/post_event.dart';
import 'repositories/post_repository.dart';
import 'view/post_consumer_view.dart';

class LayouteConcumer extends StatelessWidget {
  final PostConsumerRepository consumerRepository = PostConsumerRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'crud bloc consumer',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create:
            (_) =>
                PostConsumerBloc(consumerRepository)..add(FetchConsumerPosts()),
        child: PostConsumerView(),
      ),
    );
  }
}
