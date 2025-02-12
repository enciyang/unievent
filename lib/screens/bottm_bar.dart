import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:unievent/screens/home_screen.dart';
import 'package:unievent/screens/search_screen.dart';
import 'package:unievent/utils/event.dart';
import 'package:unievent/screens/event_screen.dart';

// 全局的 ValueNotifier 用于共享活动数据
final ValueNotifier<List<Event>> eventsNotifier = ValueNotifier<List<Event>>([]);

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  // 初始化示例活动
  @override
  void initState() {
    super.initState();
    eventsNotifier.value = [
      Event(
        title: "Sample Event 1",
        date: "10/02/2025",
        time: "10:00 AM",
        venue: "Main Hall",
        description: "This is the first sample event",
        category: "Conference",
      ),
      Event(
        title: "Sample Event 2",
        date: "11/02/2025",
        time: "2:00 PM",
        venue: "Room 202",
        description: "This is the second sample event",
        category: "Workshop",
      ),
    ];
  }

  // 底部导航选项
  late final List<Widget> _widgetOptions = [
    const HomeScreen(), // 传递 HomeScreen
    const SearchScreen(), // 传递 SearchScreen，无需显式传递 events
    const EventScreen(),
    const Text("Profile"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.blueGrey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_search_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_search_filled),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_ticket_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_ticket_filled),
            label: "My Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
            activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
