import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

/**
 * this is the implementation of the abstract class generated from the freezed plugin
 * on terminal run >> `flutter packages pub run build_runner watch --delete-conflicting-outputs`
 */
part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
abstract class Item implements _$Item {
  const Item._();

  const factory Item({
    String? id,
    required String name,
    @Default(false) bool obtained,
  }) = _Item;

  factory Item.empty() => Item(name: '');

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);

  factory Item.fromDocument(DocumentSnapshot doc) {
    // data var type should be dynamic since the data() is returning that type
    final dynamic data = doc.data()!;
    return Item.fromJson(data).copyWith(id: doc.id);
  }

  Map<String, dynamic> toDocument() => toJson()..remove("id");
}
