import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/widgets/register/register_cubit/register_cubit.dart';
import '../../shared/components/components.dart';
import 'package:memoire/widgets/register/register_cubit/register_states.dart';

enum role { admin, teacher }

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubits, RegisterState>(
        builder: (context, state) {
          return FlatButton(
            onPressed: () {
              registerDialog(context, state);
            },
           hoverColor: Colors.green,
          child:
          Container(
          height: 50,
          alignment: AlignmentDirectional.center,
          //padding: const EdgeInsets.only(top: 10, bottom: 10),
          width: 100,
          child:  Text(
          'Add User',
          style: TextStyle(color:Colors.white),

          )));
        },
        listener: (context, state) {});
  }
}
