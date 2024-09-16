import 'package:template/presentation/ui/ui.dart';
import 'package:flutter/material.dart';

class CLGProvider extends ChangeNotifier {
  bool isRefresh = false;
  bool isDisposed = false;
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  set isLoading(bool state) {
    _isLoading = state;
    if (state) {
      _isEmpty = false;
      _error = null;
    }
    notifyListeners();
  }

  bool _isEmpty = false;
  bool get isEmpty => _isEmpty;
  set isEmpty(bool state) {
    _isEmpty = state;
    notifyListeners();
  }

  CLGError? _error;
  CLGError? get error => _error;
  set error(CLGError? state) {
    _error = state;
    notifyListeners();
  }

  bool get showState => _isLoading || _isEmpty || _error != null;
  CLGPagingController pagingController = CLGPagingController();

  Function onClose = () {};
  Function onShowLoading = ([String message = '']) {};
  Function onDissmissLoading = () {};

  Function errorHandler = (Exception error) {};

  @override
  void notifyListeners() {
    if (!isDisposed) super.notifyListeners();
  }

  @override
  void dispose() {
    isDisposed = true;
    super.dispose();
  }

  Future loadPagedData([int page = 0]) async {
    if (page == 0) {
      isLoading = true;

      pagingController.reset();
      final results = await fetchPagedData();
      if (isDisposed) return;
      pagingController.setItems(results);

      isEmpty = pagingController.isEmpty;
      isLoading = false;
      isRefresh = false;
    } else {
      final results = await fetchPagedData(page);
      if (isDisposed) return;
      pagingController.addItems(results);
    }
  }

  Future loadData() async {
    isLoading = true;

    pagingController.reset();
    final results = await fetchData();
    if (isDisposed) return;
    pagingController.setItems(results);
    if (results.isNotEmpty && pagingController.scrollController.hasClients) pagingController.scrollController.jumpTo(0);

    isEmpty = pagingController.isEmpty;
    isLoading = false;
    isRefresh = false;
  }

  List<T> getSelectedItems<T>() => pagingController.selecteds.map((e) => getItem<T>(e)).toList();
  List<T> getItems<T>() => pagingController.getItems().map((e) => e as T).toList();
  void setItems<T>(List<T> list) => pagingController.setItems(list);

  T getItem<T>(int index) => pagingController.getItem(index) as T;
  void updateItem(int index, dynamic item) => pagingController.updateItem(index, item);

  Future<List<dynamic>> fetchPagedData([int page = 0]) async => [];
  Future<List<dynamic>> fetchData() async => [];
}
