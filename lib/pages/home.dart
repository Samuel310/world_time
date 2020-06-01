import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    String bgImage = data['isDaytime'] ? 'day.jpg' : 'night.jpg';
    Color txtColor = data['isDaytime'] ? Colors.black : Colors.white;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          )
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 0.0),
          child: Column(
            children: <Widget>[
              FlatButton.icon(
                onPressed: () async{
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  if(result != null){
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDaytime': result['isDaytime'],
                        'flag': result['flag']
                      };
                    });
                  }
                },
                icon: Icon(Icons.edit_location, color: txtColor,),
                label: Text('change location', style: TextStyle(color: txtColor),),
              ),
              SizedBox(height: 150.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      data['location'],
                      style: TextStyle(
                        fontSize: 20.0,
                        letterSpacing: 2.0,
                        color: txtColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                data['time'],
                style: TextStyle(
                  fontSize: 66.0,
                  color: txtColor,
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}
