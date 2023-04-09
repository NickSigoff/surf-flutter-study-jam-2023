part of 'bottom_sheet_bloc.dart';

@immutable
abstract class BottomSheetState {}

class BottomSheetInitial extends BottomSheetState {}

class BottomSheetLoading extends BottomSheetState {}

class BottomSheetSuccess extends BottomSheetState {
  final String url;

  BottomSheetSuccess(this.url);
}

class BottomSheetError extends BottomSheetState {}
