import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:surf_flutter_study_jam_2023/core/error/failure.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/domain/use_cases/ticket_use_cases/put_ticket_use_case.dart';
import '../../../../data/models/ticket_model.dart';
import '../../../../domain/use_cases/ticket_use_cases/get_all_tickets_use_case.dart';
import '../../../../domain/use_cases/ticket_use_cases/put_all_tickets_use_case.dart';

part 'ticket_storage_page_event.dart';

part 'ticket_storage_page_state.dart';

class TicketStoragePageBloc
    extends Bloc<TicketStoragePageEvent, TicketStoragePageState> {
  final GetAllTickets _getAllTickets;
  final PutTicket _putTicket;
  final PutAllTickets _putAllTickets;

  TicketStoragePageBloc(
      this._getAllTickets, this._putTicket, this._putAllTickets)
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

    on<SetTicketStatus>((event, emit) async {
      await _onSetTicketStatus(event, emit);
    });

    on<RemoveTicketEvent>((event, emit) async {
      await _onRemoveTicket(event, emit);
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

  Future<void> _onSetTicketStatus(
      SetTicketStatus event, Emitter<TicketStoragePageState> emit) async {
    if (state is TicketStoragePageSuccess) {
      final response =
          await _putTicket.call(PutTicketParams(ticket: event.ticket));
      emit((state as TicketStoragePageSuccess).copyWith());
    }
  }

  Future<void> _onRemoveTicket(
      RemoveTicketEvent event, Emitter<TicketStoragePageState> emit) async {
    if (state is TicketStoragePageSuccess) {
      final ticketsList = (state as TicketStoragePageSuccess).tickets;
      ticketsList.removeAt(event.index);
      _putAllTickets.call(PutAllTicketsParams(ticket: ticketsList));
      emit((state as TicketStoragePageSuccess).copyWith(tickets: ticketsList));
    }
  }
}
