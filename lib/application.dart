import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controllers/counter_controller.dart';
import 'controllers/todo_controller.dart';
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

  @override
  void initState() {
    counterController = CounterController();
    todoController = TodoController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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
