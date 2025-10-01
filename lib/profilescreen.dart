import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Profilescreen extends StatelessWidget {
  const Profilescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
           Positioned(
            bottom: 50,
            child: SpinKitCircle(size: 130,color: Color.fromARGB(255, 177, 92, 36))
            ),
       
          Container(
            color: const Color.fromARGB(255, 213, 219, 202),
          ),
        
          Center(
            child: Text(
              "Your profile",
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