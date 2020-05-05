import 'package:flutter/material.dart';
import './todolist.dart';
import './map.dart';
import './compass.dart';
import './calendar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(title: new Text('Mon confinement')),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              // Header avec le nom + Adresse et photo de la sidebar.
              new UserAccountsDrawerHeader(
                accountName: new Text('Théo Schmidt'),
                accountEmail: new Text('theo.schmidt@ynov.com'),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                  child: Text(
                    "TS",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              new ListTile(
                  leading: Icon(Icons.format_list_bulleted),
                  title: new Text('ToDo List'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new ToDoListPage()));
                  }),
              new ListTile(
                  leading: Icon(Icons.gps_fixed),
                  title: new Text('Carte'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new MapPage()));
                  }),
              new ListTile(
                  leading: Icon(Icons.explore),
                  title: new Text('Boussole'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new CompassPage()));
                  }),
              new ListTile(
                  leading: Icon(Icons.today),
                  title: new Text('Agenda'),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                new CalendarPage()));
                  })
            ],
          ),
        )
        /*
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      */
        );
  }
}
