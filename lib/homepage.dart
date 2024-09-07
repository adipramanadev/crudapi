import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'detailpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //function get api
  Future getData() async {
    var url = Uri.parse('https://adipramanacomputer.com/apiphp/getdata.php');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
      // print('Response data: ${response.body}'); //debugging flutter 
    } else {
      return jsonDecode(response.body);
      // print('Error: ${response.statusCode}'); //debugging flutter
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'HomePage',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => Detailpage(),
          //   ),
          // );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          //widget
          return snapshot.hasData
              ? ItemList(list: snapshot.data)
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  final List<dynamic> list; // Sesuaikan tipe data

  ItemList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return Center(child: Text("No data available"));
    }

    print('List data: $list'); // Debug print

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Detailpage(
                  list: list,
                  index: index,
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            child: ListTile(
              title: Text(list[index]['item_name'] ?? 'Nama tidak tersedia'),
              subtitle: Text(
                  'Email: ${list[index]['item_code'] ?? 'Email tidak tersedia'}'),
            ),
          ),
        );
      },
    );
  }
}
