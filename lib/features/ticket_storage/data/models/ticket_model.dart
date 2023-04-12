import 'package:hive/hive.dart';
import 'package:surf_flutter_study_jam_2023/core/file_status.dart';

part 'ticket_model.g.dart';

@HiveType(typeId: 0)
class TicketModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String url;
  @HiveField(2)
  final String ticketName;
  @HiveField(3)
  DateTime? dateCreating;
  @HiveField(4)
  DateTime? dateDownloading;
  @HiveField(5)
  String? filePath;

  TicketModel({
    required this.id,
    required this.url,
    required this.ticketName,
    this.dateCreating,
    this.dateDownloading,
    this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'ticketName': ticketName,
      'dateCreating': dateCreating,
      'dateDownloading': dateDownloading,
      'filePath': filePath,
    };
  }

  factory TicketModel.fromMap(Map<String, dynamic> map) {
    return TicketModel(
      id: map['id'] as String,
      url: map['url'] as String,
      ticketName: map['ticketName'] as String,
      dateCreating: map['dateCreating'] as DateTime,
      dateDownloading: map['dateDownloading'] as DateTime,
      filePath: map['filePath'] as String,
    );
  }
}
