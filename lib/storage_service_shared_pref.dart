import 'package:shared_preferences/shared_preferences.dart';
import 'storage_service.dart';

class StorageServiceSharedPreferences extends StorageService {
  @override
  Future<int> getCounterValue() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('counter_int_key') ?? 0;
  }

  @override
  Future<void> saveCounterValue(int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter_int_key', value);
  }
}