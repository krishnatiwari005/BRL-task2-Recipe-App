import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recipe_app/homescreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>with SingleTickerProviderStateMixin{
  @override
  void initState() {
     super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
   

   Future.delayed(Duration(seconds: 5),(){
   // ignore: use_build_context_synchronously
   Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_)=> const HomeScreen(),
  ),);
   });
  }
  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,overlays: SystemUiOverlay.values);
     super.dispose();

  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
        decoration:BoxDecoration(
          gradient: LinearGradient(colors: 
          [const Color.fromARGB(255, 237, 193, 32),const Color.fromARGB(255, 238, 98, 11)],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          "assets/gif/logo.gif",
                          height: 300,
                          width: 300,
                          fit: BoxFit.cover,
                        ),
            ),
            SizedBox(
            height: 20,
            ),
            Text("“Taste begins here.”",
            style: TextStyle(
              fontStyle:FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 28,

            ),)
          ],
        ),
      )
    );
  }
}