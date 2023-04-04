import 'package:flutter/material.dart';

class AndroidIcon extends StatelessWidget {
  const AndroidIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(child: Image.asset('assets/mylogo.gif',width: 300,height: 300,fit: BoxFit.contain,),),
      Positioned(
        top: 188,
        left: 60,
        child: Container(
          height: 92,
          width: 170,
          color: Colors.grey.shade200,
        ),
      ),
      const Positioned(
        top: 220,
        left: 50,
        child: Text('Welcome Back',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
      ),
    ]);
  }
}
