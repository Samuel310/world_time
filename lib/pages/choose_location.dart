import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:worldtime/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {

  Future<List<dynamic>> getAllLocation() async {
    try{
      Response response = await get('http://worldtimeapi.org/api/timezone/');
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      return data;
    }
    catch (e) {
      print(e.toString());
      print('error !!');
      return e;
    }
  }

  void updateTime(WorldTime worldTime) async {
    WorldTime instance = worldTime;
    await instance.getTime();
    Navigator.pop(context, {
      'location': instance.location,
      'time': instance.time,
      'isDaytime': instance.isDaytime,
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose location'),
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        elevation: 0,
      ),
      body: FutureBuilder(
        future: getAllLocation(),
        builder: (context, snapshot){
          if(snapshot.hasData){
            return (
              ListView.builder(
                itemBuilder: (context, index){
                  return Card(
                    child: ListTile(
                      onTap: () {
                        updateTime(WorldTime(location: '${snapshot.data[index]}', url: '${snapshot.data[index]}'));
                      },
                      title: Text(snapshot.data[index]),
                    ),
                  );
                },
              )
            );
          }
          else if (snapshot.hasError){
            return (
                Center(
                  child: Text('Could not load data  :(')
                )
            );
          }
          else {
            return(
                Center(
                  child: SpinKitCircle(
                    color: Colors.blue[900],
                    size: 50.0,
                  ),
                )
            );
          }
        },
      ),
    );
  }
}
