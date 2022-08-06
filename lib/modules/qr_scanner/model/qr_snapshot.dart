import 'dart:convert';

import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class QRSnapshot {
  @HiveField(0)
  final DateTime time;
  @HiveField(1)
  final String value;

  QRSnapshot(this.time, this.value);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'value': value,
    };
  }

  factory QRSnapshot.fromMap(Map<String, dynamic> map) {
    return QRSnapshot(
      DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QRSnapshot.fromJson(String source) =>
      QRSnapshot.fromMap(json.decode(source) as Map<String, dynamic>);
}
