import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controllers/counter_controller.dart';
import 'controllers/todo_controller.dart';
import 'core/repositories/todo_repository.dart';
import 'core/service/storage_service.dart';
import 'cubits/counter_cubit/counter__cubit.dart';
import 'cubits/todo_create/todo_create_cubit.dart';
import 'cubits/todo_cubit/todo_cubit.dart';
import 'locator.dart';
import 'screens/counter_screen.dart';
import 'screens/home_screen.dart';


class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late CounterController counterController;
  late TodoController todoController;
  late TodoCubit todoCubit;
  late TodoCreateCubit todoCreateCubit;
  late CounterCubit counterCubit;
  @override
  void initState() {
    counterController = locator();
    todoCubit = locator();
    todoController = locator<TodoController>();
    counterCubit = locator();
    todoCreateCubit = locator();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider.value(value: counterCubit),
        BlocProvider.value(value: todoCubit),
        BlocProvider.value(value: todoCreateCubit),
        ChangeNotifierProvider.value(value: counterController),
        ChangeNotifierProvider.value(value: todoController),
      ],
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: false,
              scaffoldBackgroundColor: Colors.grey.shade200,
              primarySwatch: Colors.green,
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
