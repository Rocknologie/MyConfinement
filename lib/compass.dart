import 'package:flutter/material.dart';
import 'package:compasstools/compasstools.dart';
import 'package:flutter/services.dart';

class CompassPage extends StatefulWidget {
  @override
  _CompassPageState createState() => new _CompassPageState();
}

class _CompassPageState extends State<CompassPage> {
  int _haveSensor;
  String sensorType;

  @override
  void initState() {
    super.initState();
    checkDeviceSensors();
  }

  Future<void> checkDeviceSensors() async {
    int haveSensor;

    try {
      haveSensor = await Compasstools.checkSensors;

      switch (haveSensor) {
        case 0:
          {
            sensorType = "Pas de capteur pour la boussole";
          }
          break;

        case 1:
          {
            sensorType = "Accéléromètre & Magnétomètre";
          }
          break;

        case 2:
          {
            sensorType = "Gyroscope";
          }
          break;

        default:
          {
            sensorType = "Error";
          }
          break;
      }
    } on Exception {}

    if (!mounted) return;

    setState(() {
      _haveSensor = haveSensor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Boussole'),
        ),
        body: new Container(
            child: Column(children: <Widget>[
          StreamBuilder(
              stream: Compasstools.azimuthStream,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Center(
                        child: new RotationTransition(
                      turns: new AlwaysStoppedAnimation(-snapshot.data / 360),
                      child: Image.asset("assets/compass-minecraft.png"),
                    )),
                  );
                } else {
                  return Text("Error in stream!");
                }
              }),
        ])));
  }
}
