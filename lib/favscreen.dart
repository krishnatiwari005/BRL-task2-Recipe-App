import 'package:flutter/material.dart';

class Favscreen extends StatelessWidget {
  const Favscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
       
          Container(
            color: const Color.fromARGB(255, 213, 219, 202),
          ),
        
          Center(
            child: Text(
              "Your Favourite Recipe",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 0, 0, 0), 
              ),
            ),
          ),
        ],
      ),
    );
  }
}
