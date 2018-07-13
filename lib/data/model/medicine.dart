import 'package:intl/intl.dart';
import 'package:medical_app/data/model/notification.dart';

class Medicine {
  final String id;
  final String barcode;
  final String name;
  final String ingredient;
  final String category;
  final String type;
  final String fors;
  final String method;
  final String notice;
  final String keeping;
  final String forget;
  final String userId;
  final int volume;
  final DateTime usageDate;
  final List<Notification> notifications;

  Medicine({
    this.id,
    this.barcode,
    this.name,
    this.ingredient,
    this.category,
    this.type,
    this.fors,
    this.method,
    this.notice,
    this.keeping,
    this.forget,
    this.userId,
    this.volume,
    this.usageDate,
    this.notifications,
  });

  @override
  String toString() {
    return '$name, ';
  }

  static List<Medicine> fromJsonArray(List<dynamic> json) {
    var medicines = json
        .map(
          (m) => new Medicine(
                id: m['id'].toString(),
                barcode: m['barcode'] ?? '',
                name: m['name'] ?? '',
                ingredient: m['ingredient'] ?? '',
                category: m['category'] ?? '',
                type: m['type'] ?? '',
                fors: m['for'] ?? '',
                method: m['method'] ?? '',
                notice: m['notice'] ?? '',
                keeping: m['keeping'] ?? '',
                forget: m['forget'] ?? '',
              ),
        )
        .toList();

    return medicines;
  }

  static List<Medicine> fromJsonUsageArray(List<dynamic> json) {
    var medicines = json
        .map(
          (m) => new Medicine(
                id: m['id'].toString(),
                barcode: m['barcode'] ?? '',
                name: m['name'] ?? '',
                ingredient: m['ingredient'] ?? '',
                category: m['category'] ?? '',
                type: m['type'] ?? '',
                fors: m['for'] ?? '',
                method: m['method'] ?? '',
                notice: m['notice'] ?? '',
                keeping: m['keeping'] ?? '',
                forget: m['forget'] ?? '',
                volume: m['volume'] ?? null,
                usageDate: new DateFormat('yyyy-MM-dd hh:mm:ss').parse(m['usage_date'])
              ),
        )
        .toList();

    return medicines;
  }

  static Medicine fromJsonNotification(Map<String, dynamic> m) {
    var medicine = new Medicine(
      id: m['id'].toString(),
      barcode: m['barcode'],
      name: m['name'],
      ingredient: m['ingredient'],
      category: m['category'],
      type: m['type'],
      fors: m['for'],
      method: m['method'],
      notice: m['notice'],
      keeping: m['keeping'],
      forget: m['forget'],
      notifications: Notification.fromJsonArray(m['user_notifications']),
    );

    return medicine;
  }

  static List<Medicine> fromJsonNotificationArray(List<dynamic> json) {
    var medicines = json
        .map(
          (m) => new Medicine(id: m['id'].toString(), barcode: m['barcode'], name: m['name'], ingredient: m['ingredient'], category: m['category'], type: m['type'], fors: m['for'], method: m['method'], notice: m['notice'], keeping: m['keeping'], forget: m['forget'], notifications: Notification.fromJsonArray(m['notifications'])),
        )
        .toList();

    return medicines;
  }
}
