import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/cubit/app_states.dart';
import 'package:memoire/widgets/register/register_widget.dart';

import '../../shared/components/footer/footer_min.dart';
import '../../shared/components/footer/footer_mx.dart';
import '../../shared/cubit/app_cubit.dart';
import '../../shared/styles/icons.dart';
import '../../widgets/add_material/add_material.dart';

import '../../widgets/login/cubit/cubit.dart';
import '../../widgets/register/register_cubit/register_states.dart';



class HomeScreenMin extends StatefulWidget {

  @override
  State<HomeScreenMin> createState() => _HomeScreenMinState();
}

GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();


class _HomeScreenMinState extends State<HomeScreenMin> {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(builder: (BuildContext context, state) {
      return Scaffold(
        backgroundColor: dark(context)? Colors.black:Colors.white,
        body:
        HawkFabMenu(
          closeIcon:Icons.close ,
          openIcon:Icons.add ,
          fabColor: Colors.green,
          iconColor: Colors.white,
          items: [
            flatIConItems(label: 'Add Classroom', onTap:  () {addClassDialog(context);}, icon: Icons.room,),
            flatIConItems(label: 'Add Reservation', onTap:  () {print(getWidth(context));}, icon: Icons.add,),
            flatIConItems(label: 'Add Material', onTap:  () {addMaterialDialog(context);}, icon: Icons.keyboard,),
            flatIConItems(label: 'Add User', onTap:  () {registerDialog(context,RegisterState); }, icon: IconBroken.Add_User,),
          ],
          body: SliderDrawer(
              splashColor: Colors.red,
              appBar:sliderAppBAr(context) ,
              key: _key,
              sliderOpenSize: 300,
              slider: sliderView(context),
              child: Container(
                width: getWidth(context),
                height: getHeight(context),
                color: dark(context)? Colors.black:Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        child: Container(
                          //  color: Colors.red,
                          color:dark(context)? Colors.black:Colors.white,
                          height: 100,
                          width: getWidth(context),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Image(image: AssetImage('assets/images/univlogo.png')),
                              const SizedBox(width: 20,),
                              Text(
                                'ABDELHAMID MEHRI \n university - UC2 \n NTIC Faculty',
                                style: TextStyle(color:dark(context)? Colors.white:Colors.black, fontSize: 16.0,height: 1.4),
                              ),


                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        //height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top: 40.0,right: 20.0),
                          child: DataTable2(
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
                                DataCell(customText(context, text: data.email!,fontSize: 12.0,upperCase: false)),
                                DataCell(customText(context, text: data.grade!,fontSize: 12.0,upperCase: false)),
                                DataCell(customText(context, text: data.place!,fontSize: 12.0,upperCase: false)),
                                //  DataCell(Text(''))
                              ])).toList()),
                        ),
                      ),
                      // const SizedBox(height: 500),
                      const SizedBox(
                        height: 700,
                      ),
                      const FooterMin()
                    ],
                  ),
                )
              )
          ),
        ),/*SliderDrawer(
          splashColor: Colors.red,
              appBar: SliderAppBar(
                appBarPadding:const EdgeInsets.all(0),
                drawerIcon:const Padding(
                  padding:  EdgeInsets.only(left: 10.0),
                  child: Icon(Icons.list,color: Colors.green,size: 40,),
                ),
               title:const Text(''),
                trailing:SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:0, right: 10,bottom: 0.0),
                        child:
                        Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.green)
                            ),
                            //padding:const EdgeInsets.all(5),
                            alignment: AlignmentDirectional.center,
                            width: 40,
                            height: 40,
                            child:const Icon(IconBroken.Search,color: Colors.white,)
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0,right: 10,bottom: 8.0),
                        child: AnimatedToggleSwitch<bool>.dual(
                          innerColor:AppCubit.get(context).isDark?Colors.white:Colors.grey ,
                          current: AppCubit.get(context).isDark,
                          first: false,
                          second: true,
                          dif: 1.0,
                          borderColor: Colors.transparent,
                          borderWidth: 5.0,
                          height: 40,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                          onChanged: (b){
                          setState(() {
                            AppCubit.get(context).changeAppMode();
                          });
                        },
                          colorBuilder: (b) => b? Colors.black : Colors.white,
                          iconBuilder: (value) => value
                              ?const Icon(Icons.brightness_4_outlined,color: Colors.white,)
                              :const Icon(Icons.brightness_4_outlined,color: Colors.black,),
                          textBuilder: (value) => !value
                              ?const Icon(Icons.brightness_4_outlined,color: Colors.grey,)
                              :const Icon(Icons.brightness_4_outlined,color: Colors.white,),
                        ),
                      ),
                    ],
                  ),
                ),
                appBarHeight: 55,
                drawerIconColor: Colors.green,
                //drawerIcon: Icon(Icons.list,color: Colors.green,size: 30,),
                  appBarColor: Colors.black,
                  ),
              key: _key,
              sliderOpenSize: 300,
              slider: _SliderView(
                onItemClick: (title) {
                  _key.currentState!.closeSlider();
                  setState(() {
                    title = title;
                  });
                },
              ),
              child: Container(
                color: dark(context)? Colors.black:Colors.white,
                child: CustomScrollView(

            slivers: [
                // headerMax(context),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) =>  Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          child: Container(
                            //  color: Colors.red,
                            color:dark(context)? Colors.black:Colors.white,
                            height: 100,
                            width: getWidth(context),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                            //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Image(image: AssetImage('assets/images/univlogo.png')),
                                SizedBox(width: 20,),
                                Text(
                                  'ABDELHAMID MEHRI \n university - UC2 \n NTIC Faculty',
                                  style: TextStyle(color:dark(context)? Colors.white:Colors.black, fontSize: 16.0,height: 1.4),
                                ),
                              ],
                            ),
                          ),
                        ),
                       // const SizedBox(height: 500),
                        const SizedBox(
                          height: 700,
                        ),
                        const footer()
                      ],
                    ),
                    childCount: 1,
                  ), //SliverChildBuildDelegate
                )
            ],
          ),
              )

          ),
*/

        /* CustomScrollView(
          slivers: [
            // headerMax(context),
            headerMainScreenMinSize(context,(b){
              setState(() {
                AppCubit.get(context).changeAppMode();
              });
            }),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) =>  Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                      child: Container(
                        //  color: Colors.red,
                        color:dark(context)? Colors.black:Colors.white,
                        height: 100,
                        width: getWidth(context),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Image(image: AssetImage('assets/images/univlogo.png')),
                            SizedBox(width: 20,),
                            Text(
                              'ABDELHAMID MEHRI \n university - UC2 \n NTIC Faculty',
                              style: TextStyle(color:dark(context)? Colors.white:Colors.black, fontSize: 16.0,height: 1.4),
                            ),
                          ],
                        ),
                      ),
                    ),
                   // const SizedBox(height: 500),
                    const SizedBox(
                      height: 700,
                    ),
                    const footer()
                  ],
                ),

                childCount: 1,
              ), //SliverChildBuildDelegate
            )
          ],
        )
        */
      );
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





