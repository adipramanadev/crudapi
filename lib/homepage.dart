import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //function get api
  Future getData() async {
    String url = 'https://jsonplaceholder.typicode.com/users';
    var response = await http.get(
      Uri.parse(url),
    );
    return json.decode(response.body);
    // print(response);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => AddPage(),
          //   ),
          // );
        },
        child: Icon(
          Icons.add,
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
  final List<dynamic>? list; // Tipe data harus sesuai
  ItemList({Key? key, this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list == null) {
      return Center(child: Text("No data available"));
    }
    return ListView.builder(
      itemCount: list!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Implementation for navigation to DetailPage
          },
          child: Card(
            child: ListTile(
              title: Text(list![index]['name']),
              leading: Icon(Icons.widgets),
              subtitle: Text('Email: ${list![index]['email']}'),
            ),
          ),
        );
      },
    );
  }
}
