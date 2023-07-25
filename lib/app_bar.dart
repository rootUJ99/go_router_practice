import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

class ShopAppbar extends StatelessWidget implements PreferredSizeWidget {
  ShopAppbar({Key? key, required this.header}) : super(key: key);
  String header;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> logout(BuildContext context) async {
    final SharedPreferences prefs = await _prefs;
    prefs.remove('user');
    context.push('/');
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(header),
      actions: [
        // ElevatedButton(
        // onPressed: () => context.pop(), child: const Text('back')),
        ElevatedButton(
            onPressed: () => logout(context), child: const Text('logout'))
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
