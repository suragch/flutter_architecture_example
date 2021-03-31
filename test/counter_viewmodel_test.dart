import 'package:flutter_architecture_example/counter_viewmodel.dart';
import 'package:flutter_architecture_example/service_locator.dart';
import 'package:flutter_architecture_example/storage_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockStorageService extends Mock implements StorageService {}

void main() {
  setUpAll(() {
    setupServiceLocator();
    getIt.allowReassignment = true;
  });

  test(
    'should increment counter',
    () async {
      // reassign storage service with a mock
      var mockStorageService = MockStorageService();
      when(mockStorageService.getCounterValue()).thenAnswer(
        (_) => Future.value(0),
      );
      getIt.registerSingleton<StorageService>(mockStorageService);

      // increment counter
      final viewModel = CounterViewModel();
      viewModel.increment();

      expect(viewModel.counter, 1);
    },
  );
}
