part of 'ticket_storage_page_bloc.dart';

@immutable
abstract class TicketStoragePageState {}

class TicketStoragePageInitial extends TicketStoragePageState {}

class TicketStoragePageSuccess extends TicketStoragePageState {
  final List<TicketModel> tickets;
  final bool isFloatingButtonVisible;

  TicketStoragePageSuccess(
      {required this.tickets, required this.isFloatingButtonVisible});

  TicketStoragePageSuccess copyWith(
      {List<TicketModel>? tickets, bool? isFloatingButtonVisible}) {
    return TicketStoragePageSuccess(
      tickets: tickets ?? this.tickets,
      isFloatingButtonVisible:
          isFloatingButtonVisible ?? this.isFloatingButtonVisible,
    );
  }
}

class TicketStoragePageLoading extends TicketStoragePageState {}

class TicketStoragePageError extends TicketStoragePageState {
  final String errorMessage;

  TicketStoragePageError(this.errorMessage);
}
