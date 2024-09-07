import 'package:flutter/material.dart';


class Detailpage extends StatefulWidget {
  final List<dynamic>? list;
  final int? index;
  Detailpage({required this.list, required this.index, super.key});

  @override
  State<Detailpage> createState() => _DetailpageState();
}

class _DetailpageState extends State<Detailpage> {
  @override
  Widget build(BuildContext context) {
    // Ensure list and index are not null before using them
    if (widget.list == null || widget.index == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Detail Page'),
          backgroundColor: Colors.red,
        ),
        body: Center(child: Text("No data available")),
      );
    }

    var item = widget.list![widget.index!]; // Safely access the item since index and list are checked

    // Now it's safe to use widget.list and widget.index
    return Scaffold(
      appBar: AppBar(
        title: Text(item['name']), // Display name in the AppBar
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Card(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Name: ${item['name']}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text('Email: ${item['email']}', style: TextStyle(fontSize: 18)),
                SizedBox(height: 10),
                Text('Phone: ${item['phone']}', style: TextStyle(fontSize: 18)),
                // Add more fields as needed
              ],
            ),
          ),
        ),
      ),
    );
  }
}
