import 'package:flutter/material.dart';
import 'package:flutter_go_router/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_go_router/firebase_options.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:provider/provider.dart';
import 'package:flutter_go_router/provider.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';

Future<void> main() async {
  // if (kIsWeb) {
  //   usePathUrlStrategy();
  // }
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // final PendingDynamicLinkData? initialLink =
  //     await FirebaseDynamicLinks.instance.getInitialLink();

  // if (initialLink != null) {
  //   final Uri deepLink = initialLink.link;
  //   // Example of using the dynamic link to push the user to a different screen
  //   // Navigator.pushNamed(context, deepLink.path);
  //   print(deepLink.path);
  //   print('inside not null condition');
  // }

  // FirebaseDynamicLinks.instance.onLink.listen(
  //   (pendingDynamicLinkData) {
  //     // Set up the `onLink` event listener next as it may be received here
  //     if (pendingDynamicLinkData != null) {
  //       final Uri deepLink = pendingDynamicLinkData.link;
  //       // Example of using the dynamic link to push the user to a different screen
  //       // Navigator.pushNamed(context, deepLink.path);
  //       print(deepLink.path);
  //       print('inside onLink condition');
  //       // context.push(deepLink.path);
  //     }
  //   },
  // );
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => DynamicLinkProvider()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  // final PendingDynamicLinkData? initialLink;
  // GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // initDynamicLink(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: goRouter,
    );
  }
}
