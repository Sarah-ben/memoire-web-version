import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/modules/home_screen/home_screen.dart';
import 'package:memoire/shared/components/constants.dart';

import '../../modules/classroom_amphi_screen/classroom_amphi_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/network/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

bool isPasswordShown = false;

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<LoginCubit, LoginStates>(
        builder: (context, state) {
          return FlatButton(
              onPressed: () {
                loginDialog(context,state);
                  },
              hoverColor: Colors.grey.withOpacity(.4),
              child:
                  const Text('Login', style: TextStyle(color: Colors.white)));
        },
        listener: (context, state) {
          if(state is LoginSuccessState){
            CacheHelper.saveData(
                  key: 'token', val: state.loginModel.token).then((value) =>print('${CacheHelper.getData(key: 'token')}')).
              then((value) => navigateTo(context,CacheHelper.getData(key: 'role')=='admin'?HomeScreen():ClassroomScreen()));
           // CacheHelper.saveData(key: 'ID', val:loginModel.userData!.id );
          }
        });
  }
}



