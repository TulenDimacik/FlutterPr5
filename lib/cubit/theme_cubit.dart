import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedprefs/cubit/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(theme: ThemeData.light()));

    late SharedPreferences sharedPreferences;

  void darkTheme() {
    final stateUpdate = ThemeState(theme: ThemeData.dark());
    emit(ThemeState(theme: stateUpdate.theme));
  }

  void lightTheme() {
    final stateUpdate = ThemeState(theme: ThemeData.light());
    emit(ThemeState(theme: stateUpdate.theme));
  }
}
