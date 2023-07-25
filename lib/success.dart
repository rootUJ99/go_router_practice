import 'package:flutter/material.dart';
import 'package:flutter_go_router/app_bar.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ShopAppbar(header: 'Success'),
      body: const Center(
        child: Column(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 100.0,
            ),
            Text('Success'),
          ],
        ),
      ),
    );
  }
}
