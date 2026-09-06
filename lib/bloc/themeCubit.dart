import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData>{
  ThemeCubit(): super(lightTheme);
  static final lightTheme = ThemeData.light();
  static final darkTheme = ThemeData.dark(

  );
  void toogleTheme() {
    if(state == lightTheme){
      emit(darkTheme);
    }
    else{
      emit(lightTheme);
    }
  }
}