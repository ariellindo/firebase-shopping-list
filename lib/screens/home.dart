import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prod_app/controllers/auth_controller.dart';

class HomeScreen extends HookWidget {
  @override
  Widget build(BuildContext context) {
    // trigger the appStarted() function so the user is always logged in
    final authControllerState = useProvider(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping List"),
        leading: authControllerState != null
            ? IconButton(
                icon: const Icon(Icons.logout),
                onPressed: () => context.read(authControllerProvider.notifier).signOut(),
              )
            : null,
      ),
      body: Container(),
    );
  }
}
