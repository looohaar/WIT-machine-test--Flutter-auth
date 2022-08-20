import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_auth/view/home.dart';
import 'package:flutter_auth/view/login_signup.dart';

import 'auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
   return StreamBuilder(
    stream: Auth().authStateChanges,
    builder: (context,snapshot){
      if (snapshot.hasData) {
        return Home();
        
      }else{
        return const LoginOrSignup();
      }

    });
    
    
  }
}