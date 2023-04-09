part of 'bottom_sheet_bloc.dart';

@immutable
abstract class BottomSheetEvent {}

class CreateBottomSheetEvent extends BottomSheetEvent{}

class PressAddButtonEvent extends BottomSheetEvent{
  final String url;
  final String ticketName;

  PressAddButtonEvent(this.url, this.ticketName);
}
