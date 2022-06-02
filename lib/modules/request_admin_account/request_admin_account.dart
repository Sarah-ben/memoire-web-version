import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memoire/shared/components/components.dart';
import 'package:memoire/shared/components/constants.dart';
import 'package:memoire/shared/styles/icons.dart';

class AdminAccountRequest extends StatelessWidget {
  const AdminAccountRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        alignment: AlignmentDirectional.center,
        width: getWidth(context),
        height: getHeight(context),
        color:  dark(context)?Colors.black:Colors.white,
        child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 80,
                child: InkWell(
                  onTap: ()=>Navigator.pop(context),
                  child: Row(
                    children: [
                       Icon(IconBroken.Arrow___Left,color:  dark(context)?Colors.white:Colors.black,),
                      Text(' Back',style: TextStyle(fontWeight: FontWeight.bold,color:  dark(context)?Colors.white:Colors.black),),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(141),
              width: getWidth(context),
              height: getHeight(context)-100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 300,
                    padding: EdgeInsets.all(20),
                    alignment: AlignmentDirectional.center,
                    decoration: BoxDecoration(
                        color: Colors.greenAccent.withOpacity(.2),
                        borderRadius: BorderRadius.circular(20)),
                    height: 320,
                    child:  Text(
                      'Only Admin requests will be submitted and treated!, to make sure that your account will be created, entre all your following  information : \nfirst name\nlast name,\nemail,\nplace,\ngrade',
                      style: TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w100, height: 2,color: dark(context)?Colors.white:Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const VerticalDivider(
                    color: Colors.green,
                    thickness: 1,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      customText(context,
                          text: '    Email to', color: Colors.green, fontSize: 10),
                      const SizedBox(
                        height: 15,
                      ),
                       Text('    sara.bensalem@univ-constantine2.dz',style: TextStyle(color:  dark(context)?Colors.white:Colors.black),),
                      const SizedBox(
                        height: 30,
                      ),
                      customText(context,
                          text: '    Infos', color: Colors.green, fontSize: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                          width: 400,
                          child: customTextField(context,
                              controller: TextEditingController(),
                              label: '',
                              textInputType: TextInputType.text,
                              maxLines: 10,textColor: Colors.black)),
                      const SizedBox(
                        height: 40,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                              width: 200,
                              child: defaultButton(function: () {}, text: 'Submit',radius: 20)),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
