import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:path_provider/path_provider.dart';
import 'package:surf_flutter_study_jam_2023/core/error/failure.dart';
import 'package:http/http.dart' as http;
import 'package:surf_flutter_study_jam_2023/core/file_status.dart';

import '../../../../data/models/ticket_model.dart';
import '../../../../domain/use_cases/ticket_use_cases/get_all_tickets_use_case.dart';

part 'ticket_storage_page_event.dart';

part 'ticket_storage_page_state.dart';

class TicketStoragePageBloc
    extends Bloc<TicketStoragePageEvent, TicketStoragePageState> {
  final GetAllTickets _getAllTickets;

  TicketStoragePageBloc(this._getAllTickets)
      : super(TicketStoragePageInitial()) {
    on<AddTicketToListEvent>((event, emit) {
      _onAddTicketToList(event, emit);
    });

    on<CreateTicketPageEvent>((event, emit) async {
      await _onCreateTicketPage(event, emit);
    });

    on<HideFloatingButtonEvent>((event, emit) {
      _onHideFloatingButton(event, emit);
    });

    on<ShowFloatingButtonEvent>((event, emit) {
      _onShowFloatingButton(event, emit);
    });

    on<UploadFileEvent>((event, emit) async {
      await _onUploadFileEvent(event, emit);
    });
  }

  void _onAddTicketToList(
      AddTicketToListEvent event, Emitter<TicketStoragePageState> emit) {
    if (state is TicketStoragePageSuccess) {
      (state as TicketStoragePageSuccess).tickets.add(event.ticket);
      emit((state as TicketStoragePageSuccess).copyWith());
    }
  }

  Future<void> _onCreateTicketPage(
      CreateTicketPageEvent event, Emitter<TicketStoragePageState> emit) async {
    emit(TicketStoragePageLoading());
    final allTickets = await _getAllTickets.call();
    List<TicketModel> tickets = [];
    allTickets.fold((failure) {
      if (failure is HiveFailure) {
        emit(TicketStoragePageError(failure.errorMessage));
      }
    }, (allTickets) {
      tickets = allTickets;
    });
    emit(TicketStoragePageSuccess(
      tickets: tickets,
      isFloatingButtonVisible: true,
    ));
  }

  void _onHideFloatingButton(
      HideFloatingButtonEvent event, Emitter<TicketStoragePageState> emit) {
    if (state is TicketStoragePageSuccess) {
      emit((state as TicketStoragePageSuccess)
          .copyWith(isFloatingButtonVisible: false));
    }
  }

  void _onShowFloatingButton(
      ShowFloatingButtonEvent event, Emitter<TicketStoragePageState> emit) {
    if (state is TicketStoragePageSuccess) {
      emit((state as TicketStoragePageSuccess)
          .copyWith(isFloatingButtonVisible: true));
    }
  }

  Future<void> _onUploadFileEvent(
      UploadFileEvent event, Emitter<TicketStoragePageState> emit) async {
    final http.StreamedResponse response = await http.Client()
        .send(http.Request('GET', Uri.parse(event.ticket.url)));
    final total = response.contentLength ?? 0;

    response.stream.listen((value) {
      print(value);
      // setState(() {
      //   _bytes.addAll(value);
      //   _received += value.length;
      // });
    }).onDone(() async {
      final file = File('${(await getApplicationDocumentsDirectory()).path}/imagedd.png');
      await file.writeAsBytes;
      event.ticket.status = FileStatus.uploaded;

    });
  }
}
