import 'package:alert/alert.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:memoire/modules/home_screen/home_screen.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/widgets/login/cubit/cubit.dart';
import 'package:memoire/widgets/register/register_cubit/register_states.dart';

import '../../../models/login_model/login_model.dart';
import '../../../shared/network/cache_helper.dart';
import '../../../shared/network/dio_helper.dart';


class RegisterCubits extends Cubit<RegisterState>{
  RegisterCubits() : super(RegisterinitialState());
  static RegisterCubits get(context)=>BlocProvider.of(context);
  late LoginModel loginModel;
  void userRegister({
    required context,
    required String email,
    required String firstName,
    required String lastName,
    required String grade,
    required String place,
    required String role,
    required String password,
    required String passwordConfirmation
  }){
    emit(RegisterLoadingState());
    DioHelper.postData(url: 'http://127.0.0.1:8000/api/register', data:{
      'first_name':firstName,
      'last_name':lastName,
      'place':place,
      'grade':grade,
      'email':email,
      'role':role,
      'password':password,
      'password_confirmation':passwordConfirmation
    },).then((value)  {
      LoginCubit.get(context).getUsers();
      print(value.data);
      flutterToast(msg: '$firstName $lastName Added Successfully', state: toastStates.success).then((value){
        Navigator.pop(context);

      });
      loginModel=LoginModel.fromJson(value.data);
      print('this is the token ${loginModel.token}');
      print('the name ${loginModel.userData!.first_name}');
      print(loginModel.userData!.id);
      CacheHelper.saveData(key: 'ID', val:loginModel.userData!.id );
      // print('$email');
      emit(RegisterSuccessState(loginModel));
    }).catchError((onError){
      flutterToast(msg: 'Something went wrong! try again.', state: toastStates.error).then((value) =>navigateTo(context, HomeScreen()));
      // flutterToast(msg: 'This email is already existed', state: toastStates.error);
      // customErrorDialog(context, text: 'This email is already used!', state: toastStates.error, type: DialogType.ERROR);
      print(onError);
      emit(RegisterErrorState(onError.toString()));
    });
  }

}