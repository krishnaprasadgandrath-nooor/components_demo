import 'dart:convert';
import 'dart:ui';

const String kId = "id";
const String kStartTime = "start_time";
const String kEndTime = "end_time";
const String kType = "type";
const String kData = "data";

enum CompType {
  image,
  text,
  button,
  question,
}

extension CompTypeUtil on CompType {
  String get lowerName => name.toLowerCase();
  static CompType fromName(String value) {
    final _lowerCase = value.toLowerCase();
    if (_lowerCase == CompType.image.lowerName) return CompType.image;
    if (_lowerCase == CompType.text.lowerName) return CompType.text;
    if (_lowerCase == CompType.button.lowerName) return CompType.button;
    if (_lowerCase == CompType.question.lowerName) return CompType.question;
    throw Exception("Error while parsing name");
  }
}

class SimpleComponent {
  final String id;
  final Duration startTime;
  final Duration endTime;
  final CompType type;
  final String data;
  final Rect rect;
  SimpleComponent(
      {required this.id,
      required this.startTime,
      required this.endTime,
      required this.type,
      required this.data,
      required this.rect});

  SimpleComponent copyWith({
    String? id,
    Duration? start_time,
    Duration? end_time,
    CompType? type,
    String? data,
    Rect? rect,
  }) {
    return SimpleComponent(
      id: id ?? this.id,
      startTime: start_time ?? this.startTime,
      endTime: end_time ?? this.endTime,
      type: type ?? this.type,
      data: data ?? this.data,
      rect: rect ?? this.rect,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'start_time': startTime.toHHMMSS,
      'end_time': endTime.toHHMMSS,
      'type': type.name,
      'data': data,
      'rect': rect.toLTWH,
    };
  }

  factory SimpleComponent.fromMap(Map<String, dynamic> map) {
    return SimpleComponent(
      id: map['id'] ?? '',
      startTime: DurationParser.fromHHMMSS(map['start_time']) ?? Duration.zero,
      endTime: DurationParser.fromHHMMSS(map['end_time']) ?? Duration.zero,
      type: CompTypeUtil.fromName(map['type']),
      data: map['data'] ?? '',
      rect: RectParser.fromLTWH(map['rect']),
    );
  }

  String toJson() => json.encode(toMap());

  factory SimpleComponent.fromJson(String source) => SimpleComponent.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SimpleComponent(id: $id, start_time: $startTime, end_time: $endTime, type: $type, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SimpleComponent &&
        other.id == id &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.type == type &&
        other.data == data;
  }

  @override
  int get hashCode {
    return id.hashCode ^ startTime.hashCode ^ endTime.hashCode ^ type.hashCode ^ data.hashCode;
  }
}

extension DurationParser on Duration {
  static Duration? fromHHMMSS(String value) {
    final strings = value.split(':');
    final intList = <int>[];
    for (var i = 0; i < 3; i++) {
      intList.add(int.tryParse(strings[i]) ?? 0);
    }
    return Duration(hours: intList.first, minutes: intList[1], seconds: intList.last);
  }

  String get toHHMMSS {
    return toString().split('.').first.padLeft(8);
  }

  String get toMMSS {
    return toString().split('.').first.padLeft(8);
  }
}

extension RectParser on Rect {
  static Rect fromLTWH(String value) {
    final ltwhList = value.split('_');
    final ltwhIntList = ltwhList.map((e) => double.tryParse(e) ?? 0).toList();
    return Rect.fromLTWH(
      ltwhIntList[0],
      ltwhIntList[1],
      ltwhIntList[2],
      ltwhIntList[3],
    );
  }

  String get toLTWH => "${left}_${top}_${width}_$height";
}
