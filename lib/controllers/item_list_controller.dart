import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prod_app/controllers/auth_controller.dart';
import 'package:prod_app/models/item_model.dart';


final itemListControllerProvider =
    StateNotifierProvider<ItemListController, AsyncValue<List<Item>>>(
  (ref) {
    final user = ref.watch(authControllerProvider);
    return ItemListController(ref.read, user?.uid);
  },
);

class ItemListController extends StateNotifier<AsyncValue<List<Item>>> {
  final Reader _read;
  final String? _userId;

  ItemListController(this._read, this._userId) : super(AsyncValue.loading());
}
