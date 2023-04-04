import 'package:flutter/material.dart';
import 'package:sjcet_leave/screens/modal_screen.dart';

class LeaveTile extends StatefulWidget {
  final String leaveImg;
  final String leaveTitle;
  final bool access;
  static String? leavetype;
  final void Function() onTap;
  const LeaveTile({
    super.key,
    required this.leaveImg,
    required this.leaveTitle,
    required this.onTap,
    this.access = false,
  });

  @override
  State<LeaveTile> createState() => _LeaveTitleState();
}

class _LeaveTitleState extends State<LeaveTile> {
     
 
  @override
  Widget build(BuildContext context) {
   
  

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 115,
        width: 115,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 10,
              )
            ]),
        child: Column(
          children: [
            const SizedBox(height: 2),
            Container(
              height: 90,
              width: 90,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(widget.leaveImg), fit: BoxFit.fill),
              ),
            ),
            Text(widget.leaveTitle,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.6),
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
