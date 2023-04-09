import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/di/di.dart' as di;

import 'features/ticket_storage/presentation/widgets/material_app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialAppWidget();
  }
}
