import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToDoListPage extends StatefulWidget {
  @override
  _ToDoListPageState createState() => new _ToDoListPageState();
}

class _ToDoListPageState extends State<ToDoListPage> {
  List categories = new List<String>();
  String input = "";

  createTodos() {
    DocumentReference documentReference =
        Firestore.instance.collection("MyConfinement").document(input);

    Map<String, String> todos = {"todoTitle": input};

    documentReference.setData(todos).whenComplete(() {
      print("$input créé");
    });
  }

  deleteTodos(item) {
    DocumentReference documentReference =
        Firestore.instance.collection("MyConfinement").document(item);

    documentReference.delete().whenComplete(() {
      print("Supprimé");
    });
  }

  void initState() {
    super.initState();
    categories.add("Maison");
    categories.add("Travail");
    categories.add("Sport");
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('ToDo List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Ajouter une tâche"),
                  content: TextField(
                    onChanged: (String value) {
                      input = value;
                    },
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          createTodos();

                          Navigator.of(context).pop();
                        },
                        child: Text("Ajouter"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("MyConfinement").snapshots(),
          builder: (context, snapshots) {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.documents.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot documentSnapshot =
                      snapshots.data.documents[index];
                  return Dismissible(
                      onDismissed: (direction) {
                        deleteTodos(documentSnapshot["todoTitle"]);
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Tâche supprimé.")));
                      },
                      key: Key(documentSnapshot["todoTitle"]),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                            title: Text(documentSnapshot["todoTitle"])),
                      ));
                });
          }),
    );
  }
}
