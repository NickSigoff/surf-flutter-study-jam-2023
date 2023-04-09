import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surf_flutter_study_jam_2023/di/di.dart' as di;

import 'features/ticket_storage/presentation/widgets/material_app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentsDir.path);
  //Hive.deleteBoxFromDisk('Tickets');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppWidget();
  }
}
