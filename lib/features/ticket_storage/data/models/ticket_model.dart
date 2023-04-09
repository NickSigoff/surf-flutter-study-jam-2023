import 'package:json_annotation/json_annotation.dart';
import 'package:surf_flutter_study_jam_2023/core/file_status.dart';

part 'ticket_model.g.dart';

@JsonSerializable()
class TicketModel {
  final String url;
  FileStatus status;

  TicketModel({
    required this.url,
    required this.status,
  });

  factory TicketModel.fromJson(Map<String, dynamic> json) =>
      _$TicketModelFromJson(json);

  Map<String, dynamic> toJson() => _$TicketModelToJson(this);
}
