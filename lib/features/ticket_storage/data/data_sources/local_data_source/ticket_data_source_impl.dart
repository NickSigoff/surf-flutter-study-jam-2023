import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/data_sources/local_data_source/ticket_data_source.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/models/ticket_model.dart';
import 'package:hive/hive.dart';

import '../../../../../core/exceptions/hive_exception.dart';

class TicketDataSourceImpl implements TicketDataSource {
  @override
  Future<List<TicketModel>> getAllTickets() async {
    try {
      final boxTickets = await Hive.openBox('Tickets');
      return boxTickets.get('tickets');
    } catch (e) {
      throw HiveException(e.toString());
    }
  }

  @override
  Future<TicketModel> getTicket() {
    // TODO: implement getTicket
    throw UnimplementedError();
  }

  @override
  Future<void> putTicket(TicketModel ticket) async {
    try {
      final boxTickets = await Hive.openBox('Tickets');
      return await boxTickets.put('tickets', ticket.toJson());
    } catch (e) {
      throw HiveException(e.toString());
    }
  }
}
