// lib/models/booking.dart

class Booking {
  final String id;
  final String serviceId;
  final String serviceName;
  final String category;
  final String date;
  final String time;
  final String status; // pending, confirmed, completed
  final String userNote;

  Booking({
    required this.id,
    required this.serviceId,
    required this.serviceName,
    required this.category,
    required this.date,
    required this.time,
    required this.status,
    required this.userNote,
  });

  factory Booking.fromJson(Map<String, dynamic> json) {
    return Booking(
      id: json['id']?.toString() ?? '',
      serviceId: json['serviceId']?.toString() ?? '',
      serviceName: json['serviceName'] ?? '',
      category: json['category'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? 'pending',
      userNote: json['userNote'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceId': serviceId,
      'serviceName': serviceName,
      'category': category,
      'date': date,
      'time': time,
      'status': status,
      'userNote': userNote,
    };
  }
}