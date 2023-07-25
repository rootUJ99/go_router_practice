import 'package:flutter/foundation.dart';

class DynamicLinkProvider with ChangeNotifier, DiagnosticableTreeMixin {
  String? _link;

  String? get link => _link;

  final List<String> _routeStack = [];

  List<String> get routeStack => _routeStack;

  void setLink(String inputlink) {
    _link = inputlink;
    notifyListeners();
  }

  void removeLink() {
    _link = null;
    notifyListeners();
  }

  void pushRoute(String route) {
    _routeStack.add(route);
    notifyListeners();
  }

  void pushRoutes(List<String> routes) {
    _routeStack.addAll(routes);
    notifyListeners();
  }

  String popRoutes() {
    final route = _routeStack.removeAt(0);
    notifyListeners();
    return route;
  }

  // /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', count));
  // }
}
