import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_go_router/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? dynamicPath;
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      initDynamicLink();
    }
    // print(route);
  }

  Future<void> handleLogin(BuildContext context, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("user", value);

    final stack = prefs.getStringList('routeStack');
    if (!mounted) return;
    if (stack == null || stack!.isEmpty) {
      context.go('/restaurant');
      return;
    }

    for (final (index, route) in stack!.indexed) {
      if (index == 0) {
        context.go(route);
        continue;
      }
      context.push(route);
    }
    prefs.remove('routeStack');
  }

  void initDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      print(deepLink.path);
      print('inside not null condition');
    }

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) async {
        final Uri deepLink = pendingDynamicLinkData.link;
        print(deepLink.path);
        print('inside onLink condition');
        setState(() {
          dynamicPath = deepLink.path;
        });
        final SharedPreferences prefs = await _prefs;
        await prefs.setString("user", "guest");
        await prefs.setString("dynamicLink", deepLink.path);
        if (mounted) {
          context.go(deepLink.path);
        }
      },
    );
  }

  final TextEditingController _controller = TextEditingController();

  Widget showRaisedButton() {
    if (dynamicPath == null) return Text('');
    return ElevatedButton(
        child: const Text('go to link'),
        onPressed: () {
          context.go(dynamicPath!);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GoRouter Test',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a user id',
                  ),
                  controller: _controller,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: const Text('Login'),
                      onPressed: () => handleLogin(context, _controller.text),
                    ),
                    ElevatedButton(
                      child: const Text('Login as guest'),
                      onPressed: () => handleLogin(context, 'guest'),
                    ),
                  ],
                ),
                showRaisedButton(),
                // _dialogBuilder(context);
              ],
            ),
          ),
        ),
      ),
    );
  }
}
