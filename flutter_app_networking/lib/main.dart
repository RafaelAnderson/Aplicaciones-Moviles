import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

// statls

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyContactList(),
    );
  }
}

// stless
class MyContactList extends StatefulWidget {
  @override
  _MyContactListState createState() => _MyContactListState();
}

class _MyContactListState extends State<MyContactList> {
  String url = 'https://randomuser.me/api/?results=15';
  List data;

  Future<String> makeRequest() async {
    var response = await http
        .get(Uri.encodeFull(url), headers: {'Accept': 'aplication/json'});

    // List data;

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata['results'];
    });

    // print('Nombre: ' + data[0]['name']['first']);
    // print('Apellido: ' + data[0]['name']['last']);
  }

/*
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Make request ...'),
          onPressed: makeRequest,
        ),
      ),
    );
  }
}
*/

  @override
  void initState() {
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact list!!!'),
      ),
      body: ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, i) {
          return ListTile(
            title: Text(data[i]['name']['first']),
            subtitle: Text(data[i]['email']),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(data[i]['picture']['thumbnail']),
            ),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          ContactDetails(data[i])));
            },
          );
        },
      ),
    );
  }
}

class ContactDetails extends StatelessWidget {
  final data;
  ContactDetails(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Details!!!'),
      ),
      body: Center(
        child: Container(
          width: 150.0,
          height: 150.0,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data['picture']['large']),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(Radius.circular(75.0)),
              border: Border.all(
                color: Colors.blue,
                width: 4.0,
              )),
        ),
      ),
    );
  }
}
