import 'package:bloc2/bloc_crud/menu/my_menu.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyMenu(), //drawer => menu
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('abdennour home 2'),
      ),
      body: Center(
        child: Text(
          'salamo alaykom',
          style: TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            // fontFamily: 'monospace',
            fontFamily: 'emoji',
          ),
        ),
      ),
    );
  }
}
