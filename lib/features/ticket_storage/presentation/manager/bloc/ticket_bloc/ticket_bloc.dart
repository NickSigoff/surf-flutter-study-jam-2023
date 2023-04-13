import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../data/models/ticket_model.dart';
import '../../../../domain/use_cases/ticket_use_cases/update_ticket_use_case.dart';

part 'ticket_event.dart';

part 'ticket_state.dart';

class TicketBloc extends Bloc<TicketEvent, TicketState> {
  final UpdateTicket _updateTicket;

  TicketBloc(this._updateTicket) : super(TicketInitial()) {
    on<LoadEvent>((event, emit) async {
      await _onLoad(event, emit);
    });

    on<StopLoadEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SetInitialValueEvent>((event, emit) {
      _onSetInitialValue(event, emit);
    });
  }

  Future<void> _onLoad(LoadEvent event, Emitter<TicketState> emit) async {
    final request = Request('GET', Uri.parse(event.ticket.url));
    final StreamedResponse response = await Client().send(request);

    final contentLength = response.contentLength;

    List<int> bytes = [];

    final file = await _getFile('${event.ticket.ticketName}.pdf');

    await emit.forEach(response.stream,
        onData: (data) {
          bytes.addAll(data);
          final downloadedLength = bytes.length;
          return TicketLoading(
              downloadedLength.toDouble() / (contentLength ?? 1),
              (contentLength ?? 1),
              downloadedLength);
        },
        onError: (error, stackTrace) => TicketError());
    await file.writeAsBytes(bytes);
    event.ticket.dateDownloading = DateTime.now();
    event.ticket.filePath = file.path;
    _updateTicket.call(UpdateTicketParams(ticket: event.ticket));
    emit(TicketLoaded(file.path));
  }

  Future<File> _getFile(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return File("${dir.path}/$filename");
  }

  void _onSetInitialValue(
      SetInitialValueEvent event, Emitter<TicketState> emit) {
    if (event.ticket.filePath != null) {
      emit(TicketLoaded(event.ticket.filePath!));
    }
  }
}
