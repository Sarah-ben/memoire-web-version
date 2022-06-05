import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/network/cache_helper.dart';
import 'package:memoire/widgets/register/register_cubit/register_cubit.dart';
import 'package:memoire/widgets/register/register_cubit/register_states.dart';
import 'package:memoire/widgets/register/register_widget.dart';
import '../../shared/components/footer/footer_min.dart';
import '../../shared/components/footer/footer_mx.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/styles/icons.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../widgets/login/cubit/cubit.dart';

class TeachersScreen extends StatefulWidget {
  @override
  State<TeachersScreen> createState() => _TeachersScreenState();
}

role _role = role.teacher;
String? text;

CustomPopupMenuController _controller = CustomPopupMenuController();
CustomPopupMenuController _notificationController = CustomPopupMenuController();


class _TeachersScreenState extends State<TeachersScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(getWidth(context));
    return BlocConsumer<RegisterCubits,RegisterState>(builder: (BuildContext context, state) {
      return Scaffold(
          backgroundColor: dark(context) ? Colors.black : Colors.white,
          body: CustomScrollView(
            slivers: [
              // headerMax(context),
              headerMainScreen(context, (b) {
                setState(() {
                  AppCubit.get(context).changeAppMode();
                });
              }),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) => Column(
                    children: [
                      CacheHelper.getData(key: 'role')=='admin'? rightMenu(context,emailHover: (hover) {
                        setState(() {
                          isEmail = hover;
                        });
                      },logoutHover:(hover) {
                        setState(() {
                          isLogOut = hover;
                        });
                      },controller: _controller, child: null
                      ): rightMenu2(context,emailHover: (hover) {
                        setState(() {
                          isEmail = hover;
                        });
                      },logoutHover:(hover) {
                        setState(() {
                          isLogOut = hover;
                        });
                      },controller: _controller,
                      ),
                      Container(
                        padding: getWidth(context) >= 1025
                            ? const EdgeInsets.symmetric(horizontal: 80)
                            : const EdgeInsets.symmetric(horizontal: 20),
                        color: dark(context) ? Colors.black : Colors.white,
                        height: 700,
                        width: double.infinity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            getWidth(context) >= 900
                                ? leftMenu(context)
                                : const SizedBox(),
                            Expanded(
                              child: SingleChildScrollView(
                                physics:const BouncingScrollPhysics(),
                                child: Padding(
                                  padding: getWidth(context) > 900
                                      ? LoginCubit.get(context).teachers.length >= 5
                                      ? const EdgeInsets.only(
                                      left: 40.0, top: 70.0)
                                      : const EdgeInsets.only(
                                      left: 70.0, top: 40.0)
                                      : const EdgeInsets.only(left: 5.0, top: 70.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customText(context, text: 'Professors ',upperCase: false),
                                      verticalSizedBox(20.0),
                                      LoginCubit.get(context).teachers.length >0? DataTable2(
                                          showCheckboxColumn: true,
                                          border: TableBorder.all(
                                              color: Colors.grey.withOpacity(.4)),
                                          headingRowColor: MaterialStateProperty.all(
                                              Colors.grey.withOpacity(.5)),
                                          //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                          columnSpacing: 12,
                                          horizontalMargin: 12,
                                          minWidth: 100,
                                          columns: [
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'first name', fontSize: 14.0),
                                              // size: ColumnSize.L,
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'last name', fontSize: 14.0),
                                            ),
                                            DataColumn2(
                                              size: ColumnSize.L,
                                              label: customText(context,
                                                  text: 'email', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'grade', fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label: customText(context,
                                                  text: 'place', fontSize: 14.0),
                                            ),

                                            const DataColumn(
                                              label: Text(''),
                                            ),
                                            const DataColumn(
                                              label: Text(''),
                                            ),

                                            /*const DataColumn(
                                            label: Text('Column NUMBERS'),
                                            numeric: false,
                                          ),*/
                                          ],
                                          rows: LoginCubit.get(context)
                                              .teachers
                                              .map((data) => DataRow(cells: [
                                            DataCell(
                                                customText(context,
                                                    text: data.first_name!,
                                                    fontSize: 12.0,
                                                    upperCase: false),
                                                onTap: () {
                                                  ReservationCubit.get(context).getAllReservation(context);
                                                  showDialog(
                                                      barrierColor: dark(context) ? Colors.white24 : Colors.black26,
                                                      context: context,
                                                      builder: (_) => AlertDialog(
                                                          backgroundColor: dark(context) ? Colors.black : Colors.white,
                                                          shape: const RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                          content: StatefulBuilder(
                                                            builder: (BuildContext context, StateSetter setState) {
                                                              return Builder(
                                                                builder: (context) {
                                                                  return SizedBox(
                                                                    width: 300,
                                                                    height: 400,
                                                                    child: ListView.separated(itemBuilder: (context,index){
                                                                      print('lists re  ${ReservationCubit.get(context).allReservations.length}');
                                                                      return elementOne(context,ReservationCubit.get(context).allReservations[index]);
                                                                    },
                                                                        separatorBuilder: (context,index)=>const Divider(), itemCount: ReservationCubit.get(context).allReservations.length),
                                                                  );
                                                                },
                                                              );
                                                            },
                                                          )));                                                 //print( ReservationCubit.get(context).getAllReservations(context, data.id));
                                                  print(data.id);
                                                }),
                                            DataCell(customText(context,
                                                text: data.last_name!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(InkWell(
                                              onTap: (){
                                                sendEmail(data.email!, 'Booking app');
                                              },
                                              child: customText(context,
                                                  text: data.email!,
                                                  fontSize: 12.0,
                                                  upperCase: false),
                                            )),
                                            DataCell(customText(context,
                                                text: data.grade!,
                                                fontSize: 12.0,
                                                upperCase: false)),
                                            DataCell(customText(context,
                                                text: data.place!,
                                                fontSize: 12.0,
                                                upperCase: false)),

                                            DataCell(
                                               getWidth(context)>=562? Row(
                                              children: [
                                                const Icon(
                                                  IconBroken.Edit,
                                                  color: Colors.yellow,
                                                  size: 15,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    TextEditingController
                                                    _firstNameController =
                                                    TextEditingController(
                                                        text: data
                                                            .first_name);
                                                    TextEditingController
                                                    _lastNameController =
                                                    TextEditingController(
                                                        text:
                                                        data.last_name);
                                                    TextEditingController
                                                    _gradeController =
                                                    TextEditingController(
                                                        text: data.grade);
                                                    TextEditingController
                                                    _placeController =
                                                    TextEditingController(
                                                        text: data.place);
                                                    updateUserDialog(context,
                                                        firstName:
                                                        _firstNameController,
                                                        lastName:
                                                        _lastNameController,
                                                        grade: _gradeController,
                                                        place: _placeController,
                                                        function: () {
                                                          if (formKey.currentState!
                                                              .validate()) {
                                                            LoginCubit.get(context).userUpdate(
                                                                id: data.id,
                                                                first_name:
                                                                _firstNameController
                                                                    .text,
                                                                last_name:
                                                                _lastNameController
                                                                    .text,
                                                                grade:
                                                                _gradeController
                                                                    .text,
                                                                place:
                                                                _placeController
                                                                    .text,
                                                                role: _role.name, context: context);
                                                            LoginCubit.get(context).getUsers();
                                                          }
                                                          //update
                                                        });
                                                    //print('tapped');
                                                    //MaterialCubit.get(context).deleteMaterial(data.id, context);
                                                  },
                                                  child: customText(context,
                                                      text: 'Edit',
                                                      color: Colors.blueGrey,
                                                      upperCase: false),
                                                )
                                              ],
                                            ):InkWell(
                                                 onTap: () {
                                                   TextEditingController
                                                   _firstNameController =
                                                   TextEditingController(
                                                       text: data
                                                           .first_name);
                                                   TextEditingController
                                                   _lastNameController =
                                                   TextEditingController(
                                                       text:
                                                       data.last_name);
                                                   TextEditingController
                                                   _gradeController =
                                                   TextEditingController(
                                                       text: data.grade);
                                                   TextEditingController
                                                   _placeController =
                                                   TextEditingController(
                                                       text: data.place);
                                                   updateUserDialog(context,
                                                       firstName:
                                                       _firstNameController,
                                                       lastName:
                                                       _lastNameController,
                                                       grade: _gradeController,
                                                       place: _placeController,
                                                       function: () {
                                                         if (formKey.currentState!
                                                             .validate()) {
                                                           LoginCubit.get(context).userUpdate(
                                                               id: data.id,
                                                               first_name:
                                                               _firstNameController
                                                                   .text,
                                                               last_name:
                                                               _lastNameController
                                                                   .text,
                                                               grade:
                                                               _gradeController
                                                                   .text,
                                                               place:
                                                               _placeController
                                                                   .text,
                                                               role: _role.name, context: context);
                                                           LoginCubit.get(context).getUsers();
                                                         }
                                                         //update
                                                       });
                                                   //print('tapped');
                                                   //MaterialCubit.get(context).deleteMaterial(data.id, context);
                                                 },
                                                 child: customText(context,
                                                     text: 'Edit',
                                                     color: Colors.blueGrey,
                                                     upperCase: false),
                                               )),
                                            DataCell(
                                               getWidth(context)>=562? Row(
                                              children: [
                                                const Icon(IconBroken.Delete,
                                                    color: Colors.red,
                                                    size: 15),
                                                InkWell(
                                                  onTap: () {

                                                    deleteConfirmation(context,
                                                        text1: data.first_name!,
                                                        text2: data.last_name,
                                                        function: () {
                                                          LoginCubit.get(context)
                                                              .deleteUser(
                                                              data.id, context);
                                                          LoginCubit.get(context).getUsers();
                                                        });
                                                  },
                                                  child: customText(context,
                                                      text: 'Delete',
                                                      color: Colors.blueGrey,
                                                      upperCase: false),
                                                ),
                                              ],
                                            ): InkWell(
                                                 onTap: () {

                                                   deleteConfirmation(context,
                                                       text1: data.first_name!,
                                                       text2: data.last_name,
                                                       function: () {
                                                         LoginCubit.get(context)
                                                             .deleteUser(
                                                             data.id, context);
                                                         LoginCubit.get(context).getUsers();
                                                       });
                                                 },
                                                 child: customText(context,
                                                     text: 'Delete',
                                                     color: Colors.blueGrey,
                                                     upperCase: false),
                                               ),),


                                            //  DataCell(Text(''))
                                          ]))
                                              .toList()):
                                    Padding(padding: EdgeInsets.all(300),
                                child: customText(context, text: 'no teachers yet',color: Colors.grey),
                              ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            /*VerticalDivider(
                                      color: Colors.grey.withOpacity(.4)),*/
                          ],
                        ),
                      ),
                      // const SizedBox(height: 500),
                      const SizedBox(
                        height: 70,
                      ),
                      getWidth(context)>=950 ?footer():FooterMin()
                    ],
                  ),
                  childCount: 1,
                ), //SliverChildBuildDelegate
              )
            ],
          ));
    }, listener: (BuildContext context, Object? state) {  },);
  }
}
/*
 WeekView(
            controller: EventController(),
            eventTileBuilder: (date, events, boundry, start, end) {
              // Return your widget to display as event tile.
              return Container();
            },
            showLiveTimeLineInAllDays: true, // To display live time line in all pages in week view.
            width: 500, // width of week view.
            minDay: DateTime.now(),
            maxDay: DateTime.parse('2100-01-01'),
            initialDay: DateTime.now(),
            heightPerMinute: 1, // height occupied by 1 minute time span.
            eventArranger: SideEventArranger(), // To define how simultaneous events will be arranged.
            onEventTap: (events, date) => print(date),
            onDateLongPress: (date) => print(date)
        )
 */

Widget menuItems({onTap, required String text, required IconData icon}) =>
    InkWell(
      hoverColor: Colors.grey,
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              size: 15,
              color: Colors.black,
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

