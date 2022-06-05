import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:memoire/modules/classroom_amphi_screen/classroom_amphi_screen.dart';
import 'package:memoire/modules/welcome_screen/welcome_screen.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/cubit/app_cubit.dart';
import 'package:memoire/shared/cubit/app_states.dart';
import 'package:memoire/shared/network/cache_helper.dart';
import 'package:memoire/shared/network/dio_helper.dart';
import 'package:memoire/shared/styles/themes.dart';
import 'package:memoire/widgets/add_clasrrom/cubit/add_cubit.dart';
import 'package:memoire/widgets/add_material/cubit/material_cubit.dart';
import 'package:memoire/widgets/add_reservation/classroom_cubit/reservation_cubit.dart';
import 'package:memoire/widgets/add_reservation/material_reservation/material_reservation_cubit.dart';
import 'package:memoire/widgets/login/cubit/cubit.dart';
import 'package:memoire/widgets/login/cubit/states.dart';
import 'package:memoire/widgets/register/register_cubit/register_cubit.dart';
import 'modules/home_screen/home_screen.dart';
import 'modules/reservations/notifications.dart';
import 'modules/welcome_screen/welcome_screen_minwidth.dart';




void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await CacheHelper.init();

  DioHelper.init();
  Widget widget;
  var token=CacheHelper.getData(key: 'token');

  if(token!=null){
     // if(CacheHelper.getData(key: 'role')=='admin')
      {widget= CacheHelper.getData(key: 'role')=='admin'? HomeScreen():ClassroomScreen();}
     // else{
     //   widget=  HomeLayout();
      //}
    }
  else{
    widget=WelcomePage();
  }
  var isDark=CacheHelper.getData(key: 'isDark');

  runApp( MyApp(startWidget: widget,isDark:isDark ,));

}

class MyApp extends StatelessWidget {
  final  isDark;
  final Widget startWidget;
   MyApp({this.isDark, required this.startWidget});

// This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers: [
      BlocProvider(create: (BuildContext context)=>AppCubit()..changeAppMode(Dark: isDark)),
      BlocProvider(create: (BuildContext context)=>LoginCubit()..getUsers()),
      BlocProvider(create: (BuildContext context)=>MaterialCubit()..getMaterial()),
      BlocProvider(create: (BuildContext context)=>MaterialReservationCubit()..getAllReservation(context)..getReservation(context)),
      BlocProvider(create: (BuildContext context)=>AddCubit()..getSalle()),
      BlocProvider(create: (BuildContext context)=>ReservationCubit()..getAllReservation(context)..getReservation(context)..getParticularClassroom()),
      BlocProvider(create: (BuildContext context)=>RegisterCubits()),
    ],
      child: BlocConsumer<AppCubit,AppStates>(
        builder: (context,state){
          return  CalendarControllerProvider(
            controller: EventController(),
            child:  MaterialApp(
                theme: lightTheme,
                themeMode: ThemeMode.light,
                darkTheme: darkTheme,
                debugShowCheckedModeBanner: false,
                //AppCubit.get(context).isDark?ThemeMode.dark:
                home:startWidget
              //we can add directionality to change direction of all app if u re using arabic
            )
          );
        },
        listener: (context,state){},
      ),);
  }
}

