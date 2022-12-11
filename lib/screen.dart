import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Screen extends StatelessWidget {
  const Screen({super.key});
  //final int count;
  
  static const routeName = '/screen2';
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    return Scaffold(
      appBar: AppBar(title: const Text("Second2")),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(arguments['stroka1'].toString()),
            Text(arguments['count'].toString()),
          ],
        ),
      ),
    );
  }
}
