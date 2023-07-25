import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterTest extends StatelessWidget {
  const GoRouterTest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoRouter Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GoRouter Test'),
        ),
        body: Center(
          child: Column(
            children: [
              const Text('GoRouter Test'),
              ElevatedButton(
                child: const Text('Go to Test 2'),
                onPressed: () => context.push('/test2:hello'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
