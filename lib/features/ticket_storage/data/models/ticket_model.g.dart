// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TicketModel _$TicketModelFromJson(Map<String, dynamic> json) => TicketModel(
      url: json['url'] as String,
      ticketName: json['ticketName'] as String,
      status: $enumDecode(_$FileStatusEnumMap, json['status']),
    );

Map<String, dynamic> _$TicketModelToJson(TicketModel instance) =>
    <String, dynamic>{
      'url': instance.url,
      'ticketName': instance.ticketName,
      'status': _$FileStatusEnumMap[instance.status]!,
    };

const _$FileStatusEnumMap = {
  FileStatus.uploaded: 'uploaded',
  FileStatus.inProgress: 'inProgress',
  FileStatus.notUploaded: 'notUploaded',
};
