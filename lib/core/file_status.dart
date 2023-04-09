import 'package:json_annotation/json_annotation.dart';

enum FileStatus{
  @JsonValue('uploaded')
  uploaded,
  @JsonValue('inProgress')
  inProgress,
  @JsonValue('notUploaded')
  notUploaded,
}