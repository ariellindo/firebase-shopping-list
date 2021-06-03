import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prod_app/controllers/auth_controller.dart';
import 'package:prod_app/controllers/item_list_controller.dart';
import 'package:prod_app/models/item_model.dart';
import 'package:prod_app/repositories/custom_exception.dart';
import 'package:prod_app/widgets/add_item_dialog.dart';
import 'package:prod_app/widgets/item_list.dart';

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
                onPressed: () =>
                    context.read(authControllerProvider.notifier).signOut(),
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddItemDialog.show(context, Item.empty()),
        child: const Icon(Icons.add),
      ),
      body: ProviderListener(
        onChange: (
          BuildContext context,
          StateController<CustomException?> customException,
        ) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Text(customException.state!.message!),
            ),
          );
        },
        provider: itemListExceptionProvider,
        child: ItemList(),
      ),
    );
  }
}
