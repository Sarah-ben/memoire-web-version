import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../shared/components/components.dart';
import 'cubit/add_cubit.dart';
import 'cubit/add_states.dart';

class ClassWidget extends StatefulWidget {
  const ClassWidget({Key? key}) : super(key: key);

  @override
  State<ClassWidget> createState() => _ClassWidgetState();
}

enum particular { yes, no }
enum Type { classroom, amphi }
String selectedClassroom = 'TD Classroom';
List<String> classType = [
  'TD Classroom',
  'TP Classroom',
  'Amphitheatre',
];

String selectedClassroomNumber = 'TD Classroom';
List<int> classNumber = [
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  41,
  42,
  43,
  44,
  45,
  46,
  47,
  48,
  49,
  50,
  51,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59,
  60
];
var salleEtage = TextEditingController();
var salleCapacity = TextEditingController();

class _ClassWidgetState extends State<ClassWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCubit, AddStates>(
      builder: (BuildContext context, state) {
        return FlatButton(

          onPressed: () {
            addClassDialog(context);
          },
          hoverColor: Colors.green,
          child: Container(
              height: 50,
            alignment: AlignmentDirectional.center,
            //padding: const EdgeInsets.only(top: 10, bottom: 10),
            width: 100,
            child:  Text(
              'Add Classroom',
              style: TextStyle(color:Colors.white),
            ),
          ),
        );
      },
      listener: (BuildContext context, Object? state) {},
    );
  }
}
