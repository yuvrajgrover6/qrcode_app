import 'dart:convert';

import 'package:hive/hive.dart';

class QRSnapshot {
  final DateTime time;
  final String value;
  final String caption;

  QRSnapshot(this.time, this.value, this.caption);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'time': time.millisecondsSinceEpoch,
      'value': value,
      'caption': caption
    };
  }

  factory QRSnapshot.fromMap(Map<String, dynamic> map) {
    return QRSnapshot(
      DateTime.fromMillisecondsSinceEpoch(map['time'] as int),
      map['value'] as String,
      map['caption'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory QRSnapshot.fromJson(String source) =>
      QRSnapshot.fromMap(json.decode(source) as Map<String, dynamic>);
}
