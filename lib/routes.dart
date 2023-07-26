// ignore_for_file: use_build_context_synchronously

import 'package:flutter_go_router/login.dart';
import 'package:flutter_go_router/menu.dart';
import 'package:flutter_go_router/private_menu.dart';
import 'package:flutter_go_router/rest.dart';
import 'package:flutter_go_router/success.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

final goRouter = GoRouter(
  initialLocation: '/',
  redirect: (context, state) async {
    final SharedPreferences prefs = await _prefs;
    String? key = await prefs.getString('user');

    if (key == null) {
      return '/';
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Login(),
      redirect: (context, state) async {
        final SharedPreferences prefs = await _prefs;
        String? key = await prefs.getString('user');

        if (key != null) {
          return '/restaurant';
        }
      },
    ),
    GoRoute(
      path: '/restaurant',
      builder: (context, state) => Rest(),
    ),
    GoRoute(path: '/menu', builder: (context, state) => Menu()),
    GoRoute(
      path: '/private-menu',
      builder: (context, state) => PrivateMenu(),
      redirect: (context, state) async {
        final SharedPreferences prefs = await _prefs;
        String? key = prefs.getString('user');
        if (key != null && key == 'guest') {
          prefs.remove('user');
          prefs.setStringList('routeStack', ['/restaurant', '/private-menu']);
          return '/';
        }
      },
    ),
    GoRoute(path: '/success', builder: (context, state) => SuccessPage()),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('path not found ${state.path}'),
    ),
  ),
  // debugLogDiagnostics: true,
);
