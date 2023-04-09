part of 'ticket_storage_page_bloc.dart';

@immutable
abstract class TicketStoragePageEvent {}

class AddTicketToListEvent extends TicketStoragePageEvent {
  final TicketModel ticket;

  AddTicketToListEvent(this.ticket);
}

class CreateTicketPageEvent extends TicketStoragePageEvent {}

class HideFloatingButtonEvent extends TicketStoragePageEvent {}

class ShowFloatingButtonEvent extends TicketStoragePageEvent {}

class SetTicketStatus extends TicketStoragePageEvent {
  final TicketModel ticket;

  SetTicketStatus(this.ticket);
}
