import 'package:get_it/get_it.dart';

import 'controllers/counter_controller.dart';
import 'controllers/todo_controller.dart';
import 'core/repositories/todo_repository.dart';
import 'core/service/storage_service.dart';
import 'cubits/counter_cubit/counter__cubit.dart';
import 'cubits/todo_cubit/todo__cubit.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<StorageService>(HiveStorageServiceImpl());

  locator.registerLazySingleton(() => TodoRepository(locator()));

  locator.registerLazySingleton(() => CounterController());
  locator.registerLazySingleton(() => TodoController(locator()));

  locator.registerFactory(() => CounterCubit());
  locator.registerFactory(() => TodoCubit(locator()));
}
