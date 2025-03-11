import 'package:get_it/get_it.dart';

import 'controllers/counter_controller.dart';
import 'controllers/todo_controller.dart';
import 'core/repositories/todo_repository.dart';
import 'core/service/storage_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => CounterController());
  locator.registerLazySingleton(() => TodoController(locator()));

  locator.registerLazySingleton(() => TodoRepository(locator()));

  locator.registerSingleton(StorageService());

}