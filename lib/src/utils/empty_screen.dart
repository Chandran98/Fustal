import 'package:flutter/material.dart';
import 'package:fustal/src/constants/constants.dart';

class EmptyPage extends StatelessWidget {
  final IconData icon;
  final String message;
  final String message1;
  const EmptyPage({Key? key, required this.icon, required this.message, required this.message1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Theme.of(context).secondaryHeaderColor,),
            spacer10,
            Text(message, 
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.w600,
              
            ),),
            const SizedBox(height: 5,),
            Text(message1, 
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400,
              color: Theme.of(context).secondaryHeaderColor
            ),)
          ],
        ),
      ),
    );
  }
}