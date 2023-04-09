import 'package:get_it/get_it.dart';
import '../features/ticket_storage/data/data_sources/local_data_source/ticket_local_data_source.dart';
import '../features/ticket_storage/data/data_sources/local_data_source/ticket_local_data_source_impl.dart';

final _getIt = GetIt.instance;

void setupDataSources() {
  _getIt.registerLazySingleton<TicketLocalDataSource>(
      () => TicketLocalDataSourceImpl());
}
