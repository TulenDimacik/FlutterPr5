import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedprefs/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: ThemeData.light()));

   void switchTheme(){
    if(state.theme == ThemeData.light()){
      emit(ThemeState(theme: ThemeData.dark()));
    }
    else{
      emit(ThemeState(theme: ThemeData.light()));
    }
  }
}
