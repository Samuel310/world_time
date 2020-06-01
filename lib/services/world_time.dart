import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;
  String time;
  String url;
  bool isDaytime;

  WorldTime({ this.location, this.url });

  Future<void> getTime() async {

    try{
      // make the request
      Response response = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);
      print(data);

      String datetime = data['datetime'];

      var tim = datetime.split("T");
      String d = tim[0];
      String t = tim[1].substring(0, tim[1].length - 6) + "Z";
      print('final: $d $t');

      DateTime dt = DateTime.parse(d+' '+t);
      isDaytime = dt.hour > 6 && dt.hour < 19 ? true : false;
      time = DateFormat.jm().format(dt);

      print('time: $time');
    }
    catch (e) {
      print(e);
      time = 'could not get time';
    }

  }

}