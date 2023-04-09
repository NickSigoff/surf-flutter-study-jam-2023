part of 'bottom_sheet_bloc.dart';

@immutable
abstract class BottomSheetEvent {}

class PressAddButtonEvent extends BottomSheetEvent{
  final String url;

  PressAddButtonEvent(this.url);
}
