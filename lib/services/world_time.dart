import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; //location name for the ui
  String time; //time in that location
  String flag; //url to an asset flag icon
  String url; // location url for API endpoint
  String ip; // client ip for API endpoint
  bool isDaytime; // true or false if day time or not

  WorldTime({this.location, this.flag, this.url, this.ip});
  Future<void> getTime() async {
    Response response = await get('https://worldtimeapi.org/api/timezone/$url');
    Map data = jsonDecode(response.body);

    //get properties from data
    String datetime = data['datetime'];
    String offset = data['utc_offset'].substring(1, 3);
    //print(datetime);
    //print(offset);

    //create a daytime object
    DateTime now = DateTime.parse(datetime);
    now = now.add(Duration(hours: int.parse(offset)));

    //set the time property
    isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
    time = DateFormat.jm().format(now);
    ip = data['client_ip'];
  }
}
