import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedprefs/cubit/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class Screen extends StatelessWidget {
  const Screen({super.key});
  //final int count;
  
  static const routeName = '/screen2';
  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
          if(arguments['theme'].toString()== '0')
    {
        context.read<ThemeCubit>().switchTheme();
      
    }
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
