import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prod_app/controllers/item_list_controller.dart';
import 'package:prod_app/models/item_model.dart';
import 'package:prod_app/repositories/custom_exception.dart';
import 'package:prod_app/widgets/add_item_dialog.dart';
import 'package:prod_app/widgets/item_list_error.dart';

class ItemList extends HookWidget {
  const ItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemListState = useProvider(itemListControllerProvider);
    final filteredItemList = useProvider(filteredItemListProvider);

    return itemListState.when(
      data: (items) => items.isEmpty
          ? const Center(
              child: Text(
              'Tap + to add an item',
              style: TextStyle(fontSize: 20.0),
            ))
          : ListView.builder(
              itemCount: filteredItemList.length,
              itemBuilder: (BuildContext context, int index) {
                final item = filteredItemList[index];
                return ProviderScope(
                  overrides: [currentItem.overrideWithValue(item)],
                  child: const ItemTile(),
                );
              }),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ItemListError(
        message:
            error is CustomException ? error.message! : 'Something went wrong!',
      ),
    );
  }
}

final currentItem = ScopedProvider<Item>((_) => throw UnimplementedError());

class ItemTile extends HookWidget {
  const ItemTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = useProvider(currentItem);
    return ListTile(
      key: ValueKey(item.id),
      title: Text(item.name),
      trailing: Checkbox(
        value: item.obtained,
        onChanged: (val) => context
            .read(itemListControllerProvider.notifier)
            .updateItem(updatedItem: item.copyWith(obtained: !item.obtained)),
      ),
      onTap: () => AddItemDialog.show(context, item),
      onLongPress: () => context
          .read(itemListControllerProvider.notifier)
          .deleteItem(itemId: item.id!),
    );
  }
}
