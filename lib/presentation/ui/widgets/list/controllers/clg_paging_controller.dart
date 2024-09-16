import 'package:flutter/material.dart';
import 'dart:io';

class CLGPagingController<T> extends ValueNotifier<int> {
  CLGPagingController() : super(0);

  ScrollController scrollController = ScrollController();
  final List<int> selecteds = [];
  final List<T> _items = [];
  int page = -1;

  bool _selectedMode = false;
  bool get selectedMode => Platform.isIOS || _selectedMode;
  set selectedMode(bool state) => _selectedMode = state;

  int get itemCount => _items.length;
  T getItem(int index) => _items[index];

  List<T> getItems() => _items;
  bool get isEmpty => _items.isEmpty;

  void selectAll(bool state) {
    selecteds.clear();
    if (state) selecteds.addAll(List.generate(_items.length, (i) => i));
    value = DateTime.now().millisecondsSinceEpoch;
  }

  void selectItem(int index, bool state) {
    selecteds.removeWhere((e) => e == index);
    if (state) selecteds.add(index);
    if (selecteds.isEmpty) selectedMode = false;
    value = DateTime.now().millisecondsSinceEpoch;
  }

  void addItems(List<T> newItems) {
    if (newItems.isNotEmpty) {
      page++;
      _items.addAll(newItems);
    }
    value = DateTime.now().millisecondsSinceEpoch;
  }

  void setItems(List<T> newItems) {
    if (newItems.isNotEmpty) {
      page = 0;
      _items.clear();
      _items.addAll(newItems);
    }
    value = DateTime.now().millisecondsSinceEpoch;
  }

  void reset() {
    _items.clear();
    selecteds.clear();
    value = 0;
    page = -1;
  }

  void updateItem(int index, T item) {
    _items.replaceRange(index, index + 1, [item]);
    value = DateTime.now().millisecondsSinceEpoch;
  }

  @override
  void dispose() {
    _items.clear();
    scrollController.dispose();
    super.dispose();
  }
}
