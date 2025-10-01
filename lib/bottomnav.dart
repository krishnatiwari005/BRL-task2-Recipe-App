
import 'package:flutter/material.dart';
import 'package:recipe_app/favscreen.dart';
import 'package:recipe_app/homescreen.dart';
import 'package:recipe_app/profilescreen.dart';

class  BottomNav extends StatefulWidget{
  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex=0;
  List<Widget>pages=[
  HomeScreen(),
  Favscreen(),
  Profilescreen(),

  ];
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: IndexedStack(                      //used to navigate different pages
        index: currentIndex,
        children: pages,
      ),
     
      bottomNavigationBar: BottomNavigationBar(
       
        backgroundColor: const Color.fromARGB(255, 237, 194, 169),
        items: 
      [
        BottomNavigationBarItem(icon:Image.asset("assets/home.png",height: 30,width: 30,),label:"Home" ),
        BottomNavigationBarItem(icon: Image.asset("assets/star.png",height: 24,width: 24,),label:"Favourite" ),
        BottomNavigationBarItem(icon :Image.asset("assets/user.png",height: 24,width: 24,),label: "profile")
      ],type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,onTap: (index) {
        setState(() {
          currentIndex=index;
        });
      },
      ),
      
    );
  }
}

