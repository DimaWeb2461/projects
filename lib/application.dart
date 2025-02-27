import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'screens/home_screen.dart';


class Application extends StatelessWidget {
  const Application({super.key});


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
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
    );
  }
}
