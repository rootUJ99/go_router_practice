import 'package:flutter/material.dart';

class GoRouterTest2 extends StatelessWidget {
  GoRouterTest2({Key? key, this.param}) : super(key: key);
  String? param = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoRouter Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GoRouter Test 2'),
        ),
        body: Center(
          child: Text('GoRouter Test 2 $param'),
        ),
      ),
    );
  }
}
