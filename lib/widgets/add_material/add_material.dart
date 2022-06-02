
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/cubit/app_cubit.dart';
import 'package:memoire/widgets/add_material/cubit/material_cubit.dart';
import '../../shared/components/components.dart';
import 'cubit/material_states.dart';

class MaterialWidget extends StatefulWidget {
  const MaterialWidget({Key? key}) : super(key: key);

  @override
  State<MaterialWidget> createState() => _MaterialWidgetState();
}

String selectedValue='Computer component';
List<String> materialType = [
  'Data show',
  'Computer component',
  'Others',
];

class _MaterialWidgetState extends State<MaterialWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MaterialCubit,MaterialStates>(builder: (BuildContext context, state) {
      return FlatButton(
          onPressed: () {
            addMaterialDialog(context);
          },
        hoverColor: Colors.green,
          child:
          Container(
            height: 50,
            alignment: AlignmentDirectional.center,
            //padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: 100,
            child:  Text(
              'Add Material',
              style: TextStyle(color:Colors.white),
            ),
          ),);
    }, listener: (BuildContext context, Object? state) {  },);
  }
}

