import 'package:flutter/material.dart';
// import 'package:recipe_app/homescreen.dart';
import 'package:recipe_app/splashscreen.dart';
void main() { 
  runApp(const MyApp()); 
  }
    class MyApp extends StatelessWidget
    {
      const MyApp({super.key});

      @override Widget build(BuildContext context) 
      { 
        return MaterialApp(   
           debugShowCheckedModeBanner: false,
           title: 'MealDB App', 
           theme: ThemeData( primarySwatch: Colors.teal,
            scaffoldBackgroundColor: const Color.fromARGB(255, 229, 162, 111), ),
          
             home: const Splashscreen(
             ),
           ); 
      }
    }
