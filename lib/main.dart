import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unievent/utils/event.dart';
import 'package:unievent/screens/bottm_bar.dart'; // 确保路径正确

final ValueNotifier<List<Event>> eventsNotifier = ValueNotifier<List<Event>>([]);

// 保存活动到本地存储
Future<void> saveEventsToStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final encodedData = jsonEncode(eventsNotifier.value.map((e) => e.toJson()).toList());
  await prefs.setString('events', encodedData);
  print("🔹 Events Saved: $encodedData"); // 调试输出
}

// 从本地存储加载活动
Future<void> loadEventsFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  final encodedData = prefs.getString('events');
  print("🔸 Loaded events: $encodedData"); // 调试输出
  if (encodedData != null) {
    final List<dynamic> decodedData = jsonDecode(encodedData);
    eventsNotifier.value = decodedData.map((e) => Event.fromJson(e)).toList();
  }
  if (encodedData != null) {
    try {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      eventsNotifier.value = decodedData.map((e) => Event.fromJson(e)).toList();
      print("✅ Successfully loaded events: ${eventsNotifier.value.length}");
    } catch (e) {
      print("❌ Error loading events: $e");
    }
  } else {
    print("⚠️ No events found in storage.");
  }

}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保 Flutter 初始化完成
  await loadEventsFromStorage(); // 启动时加载存储的活动数据
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniEvent',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BottomBar(), // 你的主页面
    );
  }
}
