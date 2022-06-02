import 'package:avatar_glow/avatar_glow.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/footer/footer_min.dart';
import 'package:memoire/shared/cubit/app_cubit.dart';
import 'package:memoire/shared/cubit/app_states.dart';

import '../../shared/components/constants.dart';
import '../../shared/styles/icons.dart';

class WelcomePageMin extends StatefulWidget {
  const WelcomePageMin({Key? key}) : super(key: key);
  @override
  State<WelcomePageMin> createState() => _WelcomePageMinState();
}

class _WelcomePageMinState extends State<WelcomePageMin> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    return BlocConsumer<AppCubit,AppStates>(builder: (context,state){
      return Scaffold(
        backgroundColor:dark(context)?Colors.black:Colors.white,
        body: CustomScrollView(
          slivers: [
            header(context),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 300,
                          child: Image.network(
                            'https://th.bing.com/th/id/R.c463f209b10a90b19c59467858e95c1c?rik=YVWlzVexqzeFWQ&pid=ImgRaw&r=0',
                            fit: BoxFit.fill,
                          ),
                        ),
                        //const SizedBox(height: double.infinity-50,),
                        Container(
                          padding:const EdgeInsets.only(left: 10.0),
                          width: double.infinity,
                          height: 300,
                          child: Padding(
                            padding:
                            const EdgeInsets.only(left: 10.0, top: 50.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'A Place Where You can Build Your Own\nRoad To Success Today',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold,
                                      height: 1.3),
                                ),
                                const SizedBox(height: 20.0,),
                                Divider(thickness: 5.0,color: Colors.lightGreenAccent,endIndent:width*.8,),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    //  color: Colors.grey,
                                  ),
                                  // borderRadius: BorderRadius.circular(20.0)),
                                  child: MaterialButton(
                                    //color: Colors.grey,
                                    hoverColor: Colors.white,
                                    onPressed: () {},
                                    child: const Text(
                                      ' Discover more ',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    Container(
                        color:AppCubit.get(context).isDark?Colors.black:Colors.white,

                        height: 600,
                        width: double.infinity,
                        child:
                        Expanded(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 50.0,right: 30.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment:AlignmentDirectional.topEnd,
                                    child:  IconButton(onPressed: (){
                                      AppCubit.get(context).changeAppMode();
                                    }, icon: Icon(Icons.brightness_4_outlined,color: AppCubit.get(context).isDark?Colors.white:Colors.black,)),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                            text:  TextSpan(
                                              text:
                                              'Welcome to Abdelhamid Mehri University Constantine2 Scholarlyworks Repository \n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 18.0,
                                                  height: 2.0,
                                                  color: dark(context)?Colors.white:Colors.black),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    'The Abdelhamid Mehri University Constanitne2 Scholarlyworks Repository aims to organize, preserve, and facilitate dissemination of publications and research outputs of the Abdelhamid Mehri University Constantine2. The majority of the items are available under open access or embargoed in accordance with restrictions set by publishers.',
                                                    style: TextStyle(
                                                      color: dark(context)?Colors.white:Colors.black,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontSize: 15.0,
                                                        height: 2.0)),
                                              ],
                                            ),
                                          ),
                                          RichText(
                                            text:  TextSpan(
                                              text:
                                              'university & incubation\n',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w800,
                                                  fontSize: 25.0,
                                                  height: 5,
                                                  color:dark(context)?Colors.white:Colors.black),
                                              children: [
                                                TextSpan(
                                                    text:
                                                    'On Sunday, March 20, 2022, a cooperation and partnership agreement was concluded between Abdul Hamid Mehri-Constantine II University and the Central Directorate of Research and Development (R&D) - Sontrak, with the aim of developing scientific and technological research and supporting university students in their innovative projects...',
                                                    style: TextStyle(
                                                      color:dark(context)?Colors.white:Colors.black ,
                                                        fontWeight:
                                                        FontWeight.normal,
                                                        fontSize: 15.0,
                                                        height: 1.8)),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 10.0,),
                                          SizedBox(
                                            width: 226,
                                            child: InkWell(
                                              onTap: () => null,
                                              onHover: (hover) {
                                                setState(() => isReadMore = hover);
                                              },
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  const SizedBox(width: 20.0,),
                                                  CircleAvatar(
                                                      backgroundColor: isReadMore
                                                          ? dark(context)?Colors.white:Colors.black:Colors.transparent,
                                                      child: Icon(
                                                        IconBroken.Arrow___Right,
                                                        color: isReadMore
                                                            ? dark(context)?Colors.black:Colors.white
                                                            : Colors.grey,
                                                      )),
                                                  const SizedBox(
                                                    width: 5.0,
                                                  ),
                                                   Text(
                                                    'Read more ',
                                                    style: TextStyle(
                                                        color: dark(context)?Colors.white:Colors.black),
                                                  )
                                                  //const SizedBox(height: 20.0,),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )),
                                  const SizedBox(
                                    height: 80.0,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MaterialButton(onPressed: (){}, child:Column(
                                        children: const[
                                          Icon(IconBroken.Activity,color: Colors.green,size: 70.0,),
                                          SizedBox(height: 10.0,),
                                          Text('Activities',style: TextStyle(color: Colors.green),)
                                        ],
                                      )),
                                      const SizedBox(width: 20.0,),
                                      MaterialButton(onPressed: (){}, child: Column(
                                        children:const [
                                          Icon(IconBroken.Setting,color: Colors.green,size: 70.0,),
                                          SizedBox(height: 10.0,),
                                          Text('Departments',style: TextStyle(color: Colors.green),)
                                        ],
                                      )),
                                      const SizedBox(width: 20.0,),
                                      MaterialButton(onPressed: (){}, child:Column(
                                        children:const [
                                          Icon(Icons.event,color: Colors.green,size: 70.0,),
                                          SizedBox(height: 10.0,),
                                          Text('Events',style: TextStyle(color: Colors.green),)


                                        ],
                                      )),
                                    ],
                                  ) ,
                                  const SizedBox(height: 20.0,)
                                ],
                              ),
                            ),
                          ),
                        )

                    ),
                   // const SizedBox(height: 50),
                    const FooterMin()
                  ],
                ),
                childCount: 1,
              ), //SliverChildBuildDelegate
            )
          ],
        ),
      );
    }, listener: (context,state){});
  }
}

/*
Text('Get in touch',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,height: 3),),
                                TextButton( onHover: (hovering) {
                                  setState(() => isHovering = hovering);
                                },onPressed: (){}, child: Text('About us',style: TextStyle(color: Colors.white,height: 1.2,decoration:isHovering==false ? TextDecoration.none:TextDecoration.underline))),
                                Text('Contact us',style: TextStyle(color: Colors.white,height: 1.2)),
                                Text('Maps & Directions',style: TextStyle(color: Colors.white,height: 1.2)),
                                Text('About us',style: TextStyle(color: Colors.white,height: 1.2)),
 */
/*
class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize:const Size.fromHeight(100.0),
      child: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leadingWidth: 90,
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(20, 30, 29, 1),
        leading:Container(
          margin:const EdgeInsets.all(8.0),
          width: 100,
            height: 200,
            child: const CircleAvatar(backgroundImage: NetworkImage('https://th.bing.com/th/id/R.e6e6c149a198cb02fa177bd0742683ba?rik=R6zJ9A7iZXeLNQ&pid=ImgRaw&r=0'),)),
        title:const Text('ABDELHAMID MEHRI \n university',style: TextStyle(color: Colors.white, fontSize: 15.0),),
        actions: [
          FlatButton(onPressed: (){},hoverColor: Colors.grey.withOpacity(.4), child:const Text('Departments',style: TextStyle(color: Colors.white))),
          FlatButton(onPressed: (){},hoverColor: Colors.grey.withOpacity(.4), child:const Text('équipe enseignant',style: TextStyle(color: Colors.white))),
          FlatButton(onPressed: (){},hoverColor: Colors.grey.withOpacity(.4), child:const Text('équipe admnisitration',style: TextStyle(color: Colors.white))),
          FlatButton(onPressed: (){},hoverColor: Colors.grey.withOpacity(.4), child:const Text('Sign in',style: TextStyle(color: Colors.white))),

        ],
      ),),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child:Image.network(
'https://th.bing.com/th/id/R.c463f209b10a90b19c59467858e95c1c?rik=YVWlzVexqzeFWQ&pid=ImgRaw&r=0'                ,
                    fit:BoxFit.cover,),
                ),
                //const SizedBox(height: double.infinity-50,),
                Container(
                  decoration: BoxDecoration(
                    //color: Colors.black.withOpacity(.3),
                    gradient:  LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                        Colors.black.withOpacity(.5),
                        Colors.black.withOpacity(.5),
                        Colors.black.withOpacity(.5),
                        Colors.white.withOpacity(.5),
                        Colors.white.withOpacity(1)

                        ])
                  ),
                  padding: EdgeInsets.only(left: 10.0),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Hello world Hello world',style: TextStyle(color: Colors.white,fontSize: 20.0,fontWeight: FontWeight.bold,height: 2.5),),
                      const Text('Hello world Hello world Hello world Hello world Hello world Hello world \nHello world Hello world Hello world Hello world Hello world \nHello world Hello world Hello world Hello world ',style: TextStyle(color: Colors.white,fontSize: 15.0,fontWeight: FontWeight.w600,height: 1.4),),
                      const SizedBox(height: 10.0,),
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(20.0)
                        ),
                        child:
                        MaterialButton(
                          color: Colors.grey,
                          hoverColor: Colors.white,
                          onPressed: (){},child:const Text(' Discover more '),),
                      )
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 1000)
          ],
        ),
      ),
    );
  }
}*/
/*
Text('About us',
                                    style: TextStyle(
                                        color: Colors.white,
                                        height: 1.2,
                                        decoration: isHoverings == false
                                            ? TextDecoration.none
                                            : TextDecoration.underline))
 */
