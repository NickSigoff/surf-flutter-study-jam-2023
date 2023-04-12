part of 'ticket_storage_page_bloc.dart';

@immutable
abstract class TicketStoragePageEvent {}

class AddTicketToListEvent extends TicketStoragePageEvent {
  final String url;
  final String name;

  AddTicketToListEvent({required this.url, required this.name});
}

class CreateTicketPageEvent extends TicketStoragePageEvent {}

class HideFloatingButtonEvent extends TicketStoragePageEvent {}

class ShowFloatingButtonEvent extends TicketStoragePageEvent {}

class RemoveTicketEvent extends TicketStoragePageEvent {
  final int index;

  RemoveTicketEvent(this.index);
}
