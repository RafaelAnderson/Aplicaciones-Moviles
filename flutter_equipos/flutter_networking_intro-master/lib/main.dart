import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Api> fetchTeams(http.Client client) async {
  
  final response =
      await client.get(
        'https://api-football-v1.p.rapidapi.com/v2/teams/league/1341',
         headers: {
           'x-rapidapi-host': "api-football-v1.p.rapidapi.com",
           'x-rapidapi-key': "d229813befmsh4c1646ad132a0b5p1313fcjsn9afecaefc97e"
         },
        );

  print(response.statusCode);
  

  if(response.statusCode == 200){
    print("Exito body");
    print(response.body);
    return Api.fromJson(json.decode(response.body));
  }

  else{
    throw Exception('Failed to load teams');
  }

}


class Team{
  int team_id;
  String name;
  String code;
  String logo;
  String country;
  bool is_national;
  int founded;
  String venue_name;
  String venue_surface;
  String venue_address;
  String venue_city;
  int venue_capacity;

  Team({this.team_id, this.name, this.code, this.logo, this.country,this.is_national,this.founded,this.venue_name,this.venue_surface,this.venue_address,this.venue_city,this.venue_capacity});

  
}

class ApiDetails {
   int _results;
   List<Team> _teams = [];

   ApiDetails(json){
     
     print('Results: '+json['results'].toString());

     _results = json['results'];
     
     List<Team> temp = [];

     for(int i = 0; i < json['teams'].length; i++){
      
      Team team = Team
      (team_id: json['teams'][i]['team_id']
      ,name: json['teams'][i]['name']
      ,code: json['teams'][i]['code']
      ,logo: json['teams'][i]['logo']
      ,country: json['teams'][i]['country']
      ,is_national: json['teams'][i]['is_national']
      ,founded: json['teams'][i]['founded']
      ,venue_name: json['teams'][i]['venue_name']
      ,venue_surface: json['teams'][i]['venue_surface']
      ,venue_address: json['teams'][i]['venue_address']
      ,venue_city: json['teams'][i]['venue_city']
      ,venue_capacity: json['teams'][i]['venue_capacity'] 
      );

      temp.add(team);
    }

     _teams = temp;
   }
  

  int get results => _results;
  List<Team> get teams => _teams;

}

class Api
{
    ApiDetails _api;
    
    Api.fromJson(Map<String, dynamic> json){
      _api = ApiDetails(json['api']);
    }

    ApiDetails get api => _api;
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    final appTitle = 'Demo Networking';
    
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   
   Icon visibleIcon = Icon(Icons.search);
   Widget searchBar= Text('Barra de búsqueda');
   List<Team> teams;

  @override
  void initState() {
    _init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: searchBar,
        actions: <Widget>[
          IconButton(
            icon: visibleIcon,
            onPressed: () {
              setState(() {

              });
            }
            )
        ],
      ),
      body: FutureBuilder<Api>(
        future: fetchTeams(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? TeamList(teams: teams)
              : Center(child: CircularProgressIndicator());
        },
      ),
      //Boton flotante
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
      ),
    );
  }

  Future _init() async{
    teams = List();
    Api apiTemp;
    apiTemp = await fetchTeams(http.Client());
    setState(() {
      teams = apiTemp.api.teams;
    });
    print("Teams size init: "+teams.length.toString());
  }
}

class TeamList extends StatelessWidget{
  
  final List<Team> teams;

  TeamList({Key key, this.teams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: teams.length,
      itemBuilder: (context, index) {
        return _buildRow(teams[index]);
      },
    );
  }

  Widget _buildRow(Team team){
    
    return Card(
      elevation: 2.0,
      child: Padding(
      padding: EdgeInsets.only(bottom: 15.0,top: 15.0),
      child: ListTile(
      leading: Image.network(team.logo),
      title: Text(
        team.name
      ),
      subtitle: Text(team.venue_name),
      trailing: 
      FittedBox(
          fit: BoxFit.fill,
          child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){},
              ),
            SizedBox(width: 8.0),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: (){},
              ),
          ],
          ),
        ),
    ),
    ),
    );
  }

}