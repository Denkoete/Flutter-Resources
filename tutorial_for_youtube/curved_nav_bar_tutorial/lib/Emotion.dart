import 'package:flutter/material.dart';


void main() => runApp(Emotion());


class Emotion extends StatelessWidget {

  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Emoiton',
      darkTheme: ThemeData.dark(

      ),

      home: MyStatefulWidget(),
    );
  }
}


class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget ({Key key}) : super (key:key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}



class _MyStatefulWidgetState extends State <MyStatefulWidget> {
  Widget build (BuildContext context) {
    return Scaffold (
      body: Center(
        child: Text('Emotion1111'),
      ),
    );
  }
}