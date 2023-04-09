part of 'bottom_sheet_bloc.dart';

@immutable
abstract class BottomSheetState {}

class BottomSheetInitial extends BottomSheetState {
  final String? copiedData;

  BottomSheetInitial({this.copiedData});
}

class BottomSheetLoading extends BottomSheetState {}

class BottomSheetSuccess extends BottomSheetState {
  final String url;

  BottomSheetSuccess(this.url);
}

class BottomSheetError extends BottomSheetState {}
