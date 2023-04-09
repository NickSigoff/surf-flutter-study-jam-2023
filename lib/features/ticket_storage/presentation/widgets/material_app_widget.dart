import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/bottom_sheet_bloc/bottom_sheet_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_storage_page_bloc/ticket_storage_page_bloc.dart';
import '../../../../core/app_locale.dart';
import '../pages/ticket_storage_page.dart';
import 'package:surf_flutter_study_jam_2023/di/di.dart' as di;

class MaterialAppWidget extends StatelessWidget {
  const MaterialAppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.getIt.get<TicketStoragePageBloc>()),
        BlocProvider(create: (_) => di.getIt.get<BottomSheetBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        localizationsDelegates: [
          AppLocale.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ru'), // Spanish
        ],
        home: const TicketStoragePage(),
      ),
    );
  }
}
