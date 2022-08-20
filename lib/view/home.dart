
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/controllers/auth.dart';

class Home extends StatelessWidget {
   Home({Key? key}) : super(key: key);
   final presentTime=DateTime.now().hour;
final User? user= Auth().currentUser;

    Future<void> signOut() async{
      await Auth().signOut();
    }
    Widget _userId(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          
           Text(
                ((presentTime<12) &&(presentTime>6))
                ?'Good Morning '
                :((presentTime>11 && (presentTime<16))
                ?'Good Afternoon '
                :((presentTime>15 && (presentTime<20))
                ?'Good Evening '
                :'Have great sleep '

                )),
                style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),),

          Text(user?.email ?? 'User email',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),),
        ],
      );

    }
    Widget _signOutButton(){
      return ElevatedButton(
      
        onPressed: signOut,
         child: const Text('Sign Out',
         style: TextStyle(fontSize: 23),));
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth',
        style:  TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
        ),
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration:const BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromARGB(255, 54, 211, 243),
              Colors.white
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter)
        ),
        child:  Padding(
          padding: EdgeInsets.all(10),
        child: Column(
          children: [
            _userId(),
            _signOutButton()

          ],
        ),),
      ),
    );
    
    
    
  }
}