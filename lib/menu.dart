import 'package:flutter/material.dart';
import 'package:flutter_go_router/app_bar.dart';
import 'package:go_router/go_router.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  void handleClickMenu(BuildContext context) async {
    context.push('/success');
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppbar(header: 'Menu'),
      body: Center(
        child: Column(children: [
          Card(
              child: ListTile(
                  title: const Text('item 1'),
                  onTap: () => handleClickMenu(context))),
          Card(
              child: ListTile(
                  title: const Text('item 2'),
                  onTap: () => handleClickMenu(context))),
          Card(
              child: ListTile(
                  title: const Text('item 3'),
                  onTap: () => handleClickMenu(context))),
          Card(
              child: ListTile(
                  title: const Text('item 4'),
                  onTap: () => handleClickMenu(context))),
          Card(
              child: ListTile(
                  title: const Text('item 5'),
                  onTap: () => handleClickMenu(context))),
          Card(
              child: ListTile(
                  title: const Text('item 6'),
                  onTap: () => handleClickMenu(context))),
        ]),
      ),
    );
  }
}
