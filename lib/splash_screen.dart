import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_3/calculator.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({super.key});

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
  with SingleTickerProviderStateMixin{

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(Duration(seconds:3), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) =>CalculatorNeuApp(),
        ));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
    overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 62, 61, 61)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            Icon(
              Icons.calculate,
              size: 100,  // Set the size as per your requirement
              color: Color.fromARGB(255, 255, 179, 0),
            ),
            Text('calmath', style: TextStyle(
              fontSize: 32,
              color: Colors.white
            ),)
          ],
        ),
      ),
    );
  }
}