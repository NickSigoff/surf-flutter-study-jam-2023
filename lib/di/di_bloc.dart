import 'package:get_it/get_it.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/bottom_sheet_bloc/bottom_sheet_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/manager/bloc/ticket_storage_page_bloc/ticket_storage_page_bloc.dart';

final _getIt = GetIt.instance;

void setupBloc() {
  _getIt.registerFactory<TicketStoragePageBloc>(() => TicketStoragePageBloc(
        _getIt(),
      ));

  _getIt.registerFactory<BottomSheetBloc>(() => BottomSheetBloc(
        _getIt(),
      ));
}
