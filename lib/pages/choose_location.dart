import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:world_time/services/world_time.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
  dynamic loader;
  bool loading = false;
  List<WorldTime> locations = [
    WorldTime(location: 'Abijan', url: 'Africa/Abidjan', flag: 'abijan.png'),
    WorldTime(location: 'Algiers', url: 'Africa/Algiers', flag: 'algeria.png'),
    WorldTime(location: 'Dubai', url: 'Asia/Dubai', flag: 'dubai.png'),
    WorldTime(location: 'Berlin', url: 'Europe/Berlin', flag: 'germany.jpg'),
    WorldTime(location: 'Cairo', url: 'Africa/Cairo', flag: 'egypt.png'),
    WorldTime(location: 'Seoul', url: 'Asia/Seoul', flag: 'china.jpg'),
    WorldTime(location: 'Jamaica', url: 'America/Jamaica', flag: 'jamaica.png'),
    WorldTime(location: 'London', url: 'Europe/London', flag: 'gbp.jpg'),
    WorldTime(location: 'Lagos', url: 'Africa/Lagos', flag: 'nigeria.jpg'),
    WorldTime(location: 'New York', url: 'America/New_York', flag: 'usa.jpg'),
    WorldTime(
        location: 'Los Angeles', url: 'America/Los_Angeles', flag: 'usa.jpg'),
    WorldTime(
        location: 'Winnipeg', url: 'America/Winnipeg', flag: 'canada.png'),
  ];

  getTimeHere(index) async {
    try {
      await locations[index].getTime();
      //print(locations[index].flag);
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });

      loader.dismiss();
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Oops!!"),
              content: Text("Network Error"),
              actions: [
                FlatButton(
                  child: Text("Close"),
                  onPressed: () {
                    Navigator.pop(
                      context,
                    );
                  },
                )
              ],
            );
          });
    }
    setState(() {
      loading = false;
    });

    loader.dismiss();
    //navigate back to home screen
    Navigator.pop(context, {
      'location': locations[index].location,
      'time': locations[index].time,
      'flag': locations[index].flag,
      'isDaytime': locations[index].isDaytime,
      'ip': locations[index].ip
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Choose Location'),
      ),
      body: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Card(
                child: ListTile(
                  onTap: () async {
                    setState(() {
                      loading = true;
                    });

                    if (loading) {
                      var dialog = await showLoadingDialog(tapDismiss: false);
                      setState(() {
                        loader = dialog;
                      });
                    }

                    getTimeHere(index);
                  },
                  title: Text(locations[index].location),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
