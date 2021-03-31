import 'dart:convert';
import 'package:http/http.dart';
import 'storage_service.dart';

class StorageServiceWeb extends StorageService {
  @override
  Future<int> getCounterValue() async {
    final url = Uri.parse('https://example.com/counter');
    Response response = await get(url);
    String json = response.body;
    Map<String, dynamic> map = jsonDecode(json);
    int counterValue = map['counter'];
    return counterValue;
  }

  @override
  Future<void> saveCounterValue(int value) async {
    final url = Uri.parse('https://example.com/counter');
    Map<String, String> headers = {'Content-type': 'application/json'};
    String json = '{"counter": $value}';
    await post(url, headers: headers, body: json);
  }
}