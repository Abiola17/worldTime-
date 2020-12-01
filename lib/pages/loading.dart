import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    try {
      WorldTime instance = WorldTime(
          location: 'Africa/Lagos', flag: 'nigeria.png', url: 'Africa/Lagos');

      await instance.getTime();
      Navigator.pushReplacementNamed(context, '/home', arguments: {
        'location': instance.location,
        'flag': instance.flag,
        'time': instance.time,
        'ip': instance.ip,
        'isDaytime': instance.isDaytime,
      });
    } catch (e) {
      _onAlertButtonsPressed(
          context,
          AlertType.none,
          'Network Error',
          'OOP! unable to connect...',
          new MaterialPageRoute(builder: (context) => new Loading()));
    }
  }

  _onAlertButtonsPressed(context, type, title, body, action) {
    Alert(
      context: context,
      type: type,
      title: title,
      desc: body,
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(59, 0, 0, 1.0),
            Color.fromRGBO(159, 0, 0, 1.0)
          ]),
        ),
        DialogButton(
          child: Text(
            "Retry",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          onPressed: () => Navigator.push(context, action),
          color: Color.fromRGBO(0, 0, 72, 1.0),
        )
      ],
    ).show();
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitFadingCircle(
          color: Colors.white,
          size: 80.0,
        ),
      ),
    );
  }
}
