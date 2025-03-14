import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'application.dart';
import 'locator.dart';


void main() async {
  await Hive.initFlutter();
  await Hive.openBox("application");
  setup();
  runApp(const Application());
}
