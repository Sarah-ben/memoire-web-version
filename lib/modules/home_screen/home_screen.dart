import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/modules/welcome_screen/welcome_screen.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/network/cache_helper.dart';
import 'package:memoire/widgets/add_reservation/classroom_cubit/reservation_list.dart';
import 'package:memoire/widgets/register/register_widget.dart';

import '../../shared/components/footer/footer_min.dart';
import '../../shared/components/footer/footer_mx.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/styles/icons.dart';
import '../../widgets/add_clasrrom/add_classroom.dart';
import '../../widgets/add_material/add_material.dart';
import '../../widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import '../../widgets/login/cubit/cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

CustomPopupMenuController _controller = CustomPopupMenuController();
CustomPopupMenuController _notificationController = CustomPopupMenuController();


class _HomeScreenState extends State<HomeScreen> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReservationCubit,ReservationStates>(listener: (BuildContext context, state) {

    }, builder: (BuildContext context, Object? state) {
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
                      },controller: _controller, notificationController: _notificationController
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
                                physics: BouncingScrollPhysics(),
                                child: Padding(
                                  padding: getWidth(context) > 900
                                      ? LoginCubit.get(context).admins.length >= 5
                                      ? const EdgeInsets.only(
                                      left: 40.0, top: 70.0)
                                      : const EdgeInsets.only(
                                      left: 70.0, top: 40.0)
                                      : const EdgeInsets.only(left: 5.0, top: 70.0),

                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      customText(context, text: 'Administrative team',upperCase: false),
                                      verticalSizedBox(20.0),
                                      DataTable2(
                                          border:TableBorder.all(color: Colors.grey.withOpacity(.4)) ,
                                          headingRowColor:MaterialStateProperty.all(Colors.grey.withOpacity(.5)) ,
                                          //dataRowColor:MaterialStateProperty.all(Colors.green) ,
                                          columnSpacing: 12,
                                          horizontalMargin: 12,
                                          minWidth: 100,
                                          columns: [
                                            DataColumn(
                                              label: customText(context, text: 'first name',fontSize: 14.0),
                                              // size: ColumnSize.L,
                                            ),
                                            DataColumn(
                                              label:  customText(context, text: 'last name',fontSize: 14.0),
                                            ),
                                            DataColumn2(
                                              size: ColumnSize.L,
                                              label:  customText(context, text: 'email',fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label:  customText(context, text: 'grade',fontSize: 14.0),
                                            ),
                                            DataColumn(
                                              label:  customText(context, text: 'place',fontSize: 14.0),
                                            ),
                                            /*const DataColumn(
                                            label: Text('Column NUMBERS'),
                                            numeric: false,
                                          ),*/
                                          ],
                                          rows:LoginCubit.get(context).admins
                                              .map((data) => DataRow(cells: [
                                            DataCell(customText(context, text: data.first_name!,fontSize: 12.0,upperCase: false)),
                                            DataCell(customText(context, text: data.last_name!,fontSize: 12.0,upperCase: false)),
                                            DataCell(InkWell(
                                                onTap: (){
                                                  sendEmail(data.email!, 'Booking app');
                                                },
                                                child: customText(context, text: data.email!,fontSize: 12.0,upperCase: false))),
                                            DataCell(customText(context, text: data.grade!,fontSize: 12.0,upperCase: false)),
                                            DataCell(customText(context, text: data.place!,fontSize: 12.0,upperCase: false)),
                                            //  DataCell(Text(''))
                                          ])).toList())

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
    },);
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

