import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/screen/edit_profile.dart';
import 'package:spagreen/src/style/theme.dart';

Widget userInfoCard(AuthUser authUser, context, authUserUpdated){
  return  GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditProfileScreen(authUser: authUser,profileUpdatedCallback:authUserUpdated ,)),
      );
    },
    child: Container(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 15, top: 20, bottom: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(authUser.imageUrl,width: 74,height: 74,fit: BoxFit.cover,),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      authUser.name,
                      style: CustomTheme.displayTextBoldColoured,
                    ),
                    if(authUser.email != null)
                    Text(
                        authUser.email.toString().length > 20?authUser.email.toString().substring(0,20)+"..":authUser.email.toString(),
                      style: CustomTheme.subTitleText,
                    ),
                  ],
                ),
              ],
            ),
            Image.asset(
              'assets/images/common/arrow_forward.png',
              scale: 2.5,
            ),
          ],
        ),
      ),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
        boxShadow: CustomTheme.boxShadow,
        color: Colors.white,
      ),
    ),
  );
}