import 'package:firebase_core/firebase_core.dart';
import 'package:prod_app/general_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prod_app/models/item_model.dart';
import 'package:prod_app/repositories/custom_exception.dart';
import 'package:prod_app/extensions/firebase_firestore_extension.dart';

abstract class BaseItemRepository {
  Future<List<Item>> retrieveItems({required String userId});
  Future<String> createItems({required String userId, required Item item});
  Future<void> updateItem({required String userId, required Item item});
  Future<void> deleteItem({required String userId, required String itemId});
}

class ItemRepository implements BaseItemRepository {
  final Reader _read;

  const ItemRepository(this._read);

  @override
  Future<String> createItems(
      {required String userId, required Item item}) async {
    try {
      final docRef = await _read(firebaseFirestoreProvider)
          .usersListRef(userId)
          .add(item.toDocument());
      return docRef.id;
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<List<Item>> retrieveItems({required String userId}) async {
    try {
      final snap = await _read(firebaseFirestoreProvider)
          .collection('lists')
          .doc(userId)
          .collection('userList')
          .get();
      return snap.docs.map((doc) => Item.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> updateItem({required String userId, required Item item}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('lists')
          .doc(userId)
          .collection('userLists')
          .doc(item.id)
          .update(item.toDocument());
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }

  @override
  Future<void> deleteItem(
      {required String userId, required String itemId}) async {
    try {
      await _read(firebaseFirestoreProvider)
          .collection('lists')
          .doc(userId)
          .collection('lists')
          .doc(itemId)
          .delete();
    } on FirebaseException catch (e) {
      throw CustomException(message: e.message);
    }
  }
}
