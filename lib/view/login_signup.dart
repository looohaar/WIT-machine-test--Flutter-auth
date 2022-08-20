

import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../controllers/auth.dart';

class LoginOrSignup extends StatefulWidget {
  const LoginOrSignup({Key? key}) : super(key: key);

  @override
  State<LoginOrSignup> createState() => _LoginOrSignupState();
}

class _LoginOrSignupState extends State<LoginOrSignup> {
  String? errorMessage='';
  bool loggedIn= true;
  final _emailController= TextEditingController();
  final _passwordController= TextEditingController();
  Future<void> signInWithEmailAndPassword()async{
    try {
      await Auth().signInWithEmailAndPassword(
        email: _emailController.text,
         password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage= e.message;
      });
      
    }
  }
  Future<void> createUserWithEmailAndPassword()async{
    try {
      await Auth().createUserWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text);
    }on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage= e.message;
      });
      
    }
  }
  Widget _inputField( String title, TextEditingController controller){
   

    return TextField(
      textAlign: TextAlign.justify,
      
      style: TextStyle(
        fontSize: 20
      ),


      controller: controller,
    
      maxLines: 1,
      obscureText: title=='Email'?false: true,
      decoration: InputDecoration(
        
        prefixIcon: title=='Email'? const Icon(Icons.mail): const Icon(Icons.password_sharp),
        
        hintText: title,
        fillColor: Color.fromARGB(255, 221, 242, 239),
        filled: true,
        border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        
        )
      ),
    );
  }
  Widget _submitButton(){
    return ElevatedButton(
      onPressed: loggedIn? signInWithEmailAndPassword : createUserWithEmailAndPassword,

       child: Text(loggedIn? 'Login' : 'Sign Up',
       style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w400
       ),
       ),
       );
  }
  Widget _loginOrSignupButton(){
    return TextButton(
      onPressed:(){
        setState(() {
          loggedIn=!loggedIn;
        });
      },
       child: Text(loggedIn?' New user? Register now!':'Already hvae an account ?? Login',
       style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold

       ),));
  }
  Widget _errorMessage(){
    return Text(errorMessage ==''?'': '${errorMessage}');
  }
  final SizedBox height20= SizedBox(height: 20,);
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
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _inputField('Email', _emailController),
          height20,
          _inputField('Password', _passwordController),
          height20,
          _errorMessage(),
          height20,
          _submitButton(),
    
          _loginOrSignupButton(),

        ],
      ),
    ),
  ); 
    
  }
}