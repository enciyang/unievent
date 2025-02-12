import 'dart:convert';

class Event {
  String title;
  String date;
  String time;
  String venue;
  String description;
  String category;
  bool isJoined;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.venue,
    required this.description,
    required this.category,
    this.isJoined = false,
  });

  // **JSON 序列化**
  factory Event.fromJson(Map<String, dynamic> json) => Event(
    title: json["title"],
    date: json["date"],
    time: json["time"],
    venue: json["venue"],
    description: json["description"],
    category: json["category"],
    isJoined: json["isJoined"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "date": date,
    "time": time,
    "venue": venue,
    "description": description,
    "category": category,
    "isJoined": isJoined,
  };

  // **用于调试，打印事件详情**
  @override
  String toString() {
    return 'Event(title: $title, date: $date, time: $time, venue: $venue, category: $category, isJoined: $isJoined)';
  }
}

// **解析 JSON 列表**
List<Event> decodeEvents(String jsonString) {
  final List<dynamic> decoded = jsonDecode(jsonString);
  return decoded.map((e) => Event.fromJson(e)).toList();
}

// **转换成 JSON 字符串**
String encodeEvents(List<Event> events) {
  return jsonEncode(events.map((e) => e.toJson()).toList());
}
