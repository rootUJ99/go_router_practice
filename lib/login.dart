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
    if (kIsWeb) {
      initDynamicLink();
    }
    // print(route);
  }

  Future<void> handleLogin(BuildContext context, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString("user", value);
    // context.push('/test2:$value');
    // print(context.watch<DynamicLinkProvider>().link);

    // final List<String> stack =
    // context.watch()<DynamicLinkProvider>().routeStack;
    final stack = await prefs.getStringList('routeStack');
    if (stack == null || stack!.isEmpty) {
      context.go('/restaurant');
      return;
    }

    while (stack!.length > 0) {
      // String route = context.read()<DynamicLinkProvider>().popRoute();
      String route = stack!.removeAt(0);
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
      (pendingDynamicLinkData) {
        if (pendingDynamicLinkData != null) {
          final Uri deepLink = pendingDynamicLinkData.link;
          print(deepLink.path);
          print('inside onLink condition');
          setState(() {
            dynamicPath = deepLink.path;
          });
          context.read<DynamicLinkProvider>().setLink(deepLink.path);
        }
      },
    );
  }

  final TextEditingController _controller = TextEditingController();

  Widget showRaisedButton() {
    final link = context.watch<DynamicLinkProvider>().link;
    if (link == null) return Text('no dynamic links');
    return ElevatedButton(
        child: const Text('go to link'),
        onPressed: () {
          context.push(link);
        });
  }

  // Future<Widget> _dialogBuilder(BuildContext context) async{
  //   final link = context.watch<DynamicLinkProvider>().link;

  //   Widget valu = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       if (link == null) return Text('no dynamic links');
  //       return AlertDialog(
  //         title: const Text('open a direct link to a path'),
  //         content: ElevatedButton(
  //             child: const Text('go to link'),
  //             onPressed: () {
  //               context.push(link!);
  //             }),
  //         actions: <Widget>[
  //           TextButton(
  //             style: TextButton.styleFrom(
  //               textStyle: Theme.of(context).textTheme.labelLarge,
  //             ),
  //             child: const Text('Disable'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     });
  //     return valu;
  // }

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
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter a user id',
                ),
                controller: _controller,
              ),
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
              Text(dynamicPath ?? 'no link'),
              Text(context.watch<DynamicLinkProvider>().link ??
                  'no provider link'),
              showRaisedButton(),
              // _dialogBuilder(context);
            ],
          ),
        ),
      ),
    );
  }
}
