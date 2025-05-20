import 'package:bloc2/bloc_crud/bloc_builder/view/post_builder_view.dart';
import 'package:bloc2/bloc_crud/bloc_consumer/view/post_consumer_view.dart';
import 'package:bloc2/bloc_crud/bloc_listener/view/post_listener_view.dart';
import 'package:bloc2/bloc_crud/menu/home.dart';
import 'package:flutter/material.dart';

class Globalparams {
  static List<Map<String, dynamic>> menu = [
    {'title': 'HOME', 'icon': Icons.home, 'route': '/'},
    {
      'title': 'CRUD BUILDER',
      'icon': Icons.access_alarm,
      'route': '/crud_builder',
    },
    {
      'title': 'CRUD CONSUMER',
      'icon': Icons.access_alarm,
      'route': '/crud_consumer',
    },
    {
      'title': 'CRUD LISTENER',
      'icon': Icons.access_alarm,
      'route': '/crud_listener',
    },
  ];
  static Map<String, Widget Function(dynamic)> routes = {
    '/': (context) => Home(),
    '/crud_builder': (context) => PostBuilderView(),
    '/crud_consumer': (context) => PostConsumerView(),
    '/crud_listener': (context) => PostListenerView(),
  };
}
