import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/shared/network/dio_helper.dart';

import '../network/cache_helper.dart';
import 'app_states.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());
  static AppCubit get(context) => BlocProvider.of(context);
  bool isDark=false;
  ThemeMode appMode=ThemeMode.dark;

  void changeAppMode({ bool? Dark}) {
    if (Dark != null) {
      isDark = Dark;
      emit(ChangeAppTheme());
    } else {
      isDark = !isDark;
      CacheHelper.putData(key: 'isDark', val: isDark).then((value) {
        emit(ChangeAppTheme());
      });
    }
  }
  void changeSliderMode(){
    changeAppMode();
    emit(SliderChangeAppMode());
  }
}