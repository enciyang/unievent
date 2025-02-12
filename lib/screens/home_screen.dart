import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:unievent/utils/event.dart';
import 'package:unievent/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final titleController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final venueController = TextEditingController();
  final descriptionController = TextEditingController();
  String selectedCategory = "Conference";

  @override
  void initState() {
    super.initState();
    loadEventsFromStorage();
  }

  void _addEvent() {
    final newEvent = Event(
      title: titleController.text,
      date: dateController.text,
      time: timeController.text,
      venue: venueController.text,
      description: descriptionController.text,
      category: selectedCategory,
    );
    eventsNotifier.value = [...eventsNotifier.value, newEvent];
    saveEventsToStorage();
    _clearForm();
  }

  void _deleteEvent(int index) {
    eventsNotifier.value = List.from(eventsNotifier.value)..removeAt(index);
    saveEventsToStorage();
  }

  void _clearForm() {
    titleController.clear();
    dateController.clear();
    timeController.clear();
    venueController.clear();
    descriptionController.clear();
    setState(() {
      selectedCategory = "Conference";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Event Manager"),
        backgroundColor: Colors.blueAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Create New Event",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Gap(10),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Title",
                prefixIcon: Icon(Icons.event),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Gap(10),
            TextField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: "Date",
                prefixIcon: Icon(Icons.calendar_today),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  dateController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
                }
              },
            ),
            const Gap(10),
            TextField(
              controller: timeController,
              decoration: InputDecoration(
                labelText: "Time",
                prefixIcon: Icon(Icons.access_time),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              readOnly: true,
              onTap: () async {
                TimeOfDay? pickedTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (pickedTime != null) {
                  timeController.text = pickedTime.format(context);
                }
              },
            ),
            const Gap(10),
            TextField(
              controller: venueController,
              decoration: InputDecoration(
                labelText: "Venue",
                prefixIcon: Icon(Icons.location_on),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Gap(10),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: "Description",
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Gap(10),
            DropdownButtonFormField(
              value: selectedCategory,
              items: ["Conference", "Workshop", "Meetup", "Party", "Other"]
                  .map((category) => DropdownMenuItem(value: category, child: Text(category)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value!;
                });
              },
              decoration: InputDecoration(
                labelText: "Category",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Gap(20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _addEvent,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Add Event",
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}