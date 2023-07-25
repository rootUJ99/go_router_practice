import 'package:flutter/material.dart';
import 'package:flutter_go_router/app_bar.dart';
import 'package:go_router/go_router.dart';

class Rest extends StatelessWidget {
  const Rest({Key? key}) : super(key: key);

  Future<void> handleClickRest(BuildContext context) async {
    context.push('/menu');
  }

  Future<void> handleClickRestPrivate(BuildContext context) async {
    context.push('/private-menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppbar(header: 'Rest'),
      body: Center(
        child: Column(children: [
          Card(
            child: ListTile(
                title: const Text('Paid Course'),
                subtitle:
                    const Text('user should be logged in for this course'),
                onTap: () => handleClickRestPrivate(context)),
          ),
          Card(
            child: ListTile(
                title: const Text('Free Course'),
                subtitle: const Text('Any user can access this course'),
                onTap: () => handleClickRest(context)),
          ),
        ]),
      ),
    );
  }
}
