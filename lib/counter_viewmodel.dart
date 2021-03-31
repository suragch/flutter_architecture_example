import 'package:flutter/foundation.dart';
import 'service_locator.dart';
import 'storage_service.dart';

class CounterViewModel extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;

  StorageService _storageService = getIt<StorageService>();

  Future loadData() async {
    _counter = await _storageService.getCounterValue();
    notifyListeners();
  }

  void increment() {
    _counter++;
    _storageService.saveCounterValue(_counter);
    notifyListeners();
  }
}
