import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listdemo/home/home_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Timer? _timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _timer = Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue ,Colors.purple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft
                )
            ),
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.contact_page
                    ,size: 50,color: Colors.white
                ),
                SizedBox(height: 20.0),
                Text('Welcome',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 50 ,color: Colors.white ,fontWeight: FontWeight.bold),)
              ],

            )
        )
    );

  }
}
