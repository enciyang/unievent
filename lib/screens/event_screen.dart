import 'package:flutter/material.dart';
import 'package:unievent/utils/event.dart';
import 'package:unievent/main.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Joined Events"),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ValueListenableBuilder<List<Event>>(
          valueListenable: eventsNotifier,
          builder: (context, events, child) {
            final userJoinedEvents = events.where((event) => event.isJoined).toList();

            return userJoinedEvents.isEmpty
                ? const Center(
              child: Text(
                "You have not joined any events.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: userJoinedEvents.length,
              itemBuilder: (context, index) {
                final event = userJoinedEvents[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.event, color: Colors.blueAccent),
                    title: Text(
                      event.title,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    subtitle: Text("${event.date} at ${event.time} - ${event.venue}"),
                    trailing: const Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
