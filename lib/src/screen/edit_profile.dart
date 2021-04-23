import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:spagreen/src/models/account_deactivate.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/server/repository.dart';
import 'package:spagreen/src/services/authentication_service.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import 'package:spagreen/src/utils/edit_text_utils.dart';
import 'package:spagreen/src/utils/loadingIndicator.dart';
import 'package:spagreen/src/utils/validators.dart';
import '../../app.dart';
import '../../constants.dart';
import '../button_widget.dart';
import 'dart:io';

class EditProfileScreen extends StatefulWidget {
  final AuthUser authUser;
  final void Function() profileUpdatedCallback;

  const EditProfileScreen({Key key,@required this.authUser,@required this.profileUpdatedCallback}) : super(key: key);
  @override
  _EditProfileScreenState createState(){
    // TODO: implement createState
    return  _EditProfileScreenState();
  }
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  AuthService _authService;
  final deactivateFormKey = GlobalKey<FormState>();
  TextEditingController editProfileNameController ;
  TextEditingController editProfileEmailController ;
  TextEditingController editProfilePhoneController ;
  TextEditingController deleteController = new TextEditingController();
  TextEditingController accountDeactivateReasonController = new TextEditingController();
  List gender=["Male","Female","Other"];
  String select ;
  AccountDeactivate _accountDeactivate;
  File _image;
  final picker = ImagePicker();
  bool isLoading = false;
  AuthUser updatedUser;

  //get Image Function
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery,maxHeight: 120,maxWidth: 120);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    editProfileNameController = new TextEditingController(text: widget.authUser.name);
    editProfileEmailController = new TextEditingController(text: widget.authUser.email);
    editProfilePhoneController = new TextEditingController(text: widget.authUser.phone != null ? widget.authUser.phone :'');
    select = widget.authUser.gender;
  }

  @override
  Widget build(BuildContext context) {
    printLog("_EditProfileScreenState");
    _authService = Provider.of<AuthService>(context);
    double screnWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //app title
              _renderAppBar(),
              //_renderProfileWidget
              _renderProfileWidget(screnWidth, _authService),
              //account deactivate card
              _renderAccountDeactiveWidget(screnWidth,context),
            ],
          ),
        ),
      ),
    );
  }

  //renderAppBar
  Widget _renderAppBar() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40,
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              GestureDetector(
                  onTap: (){Navigator.of(context).pop();},
                  child: Icon(Icons.arrow_back_ios)),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(AppContent.titleSettingsScreen,
                    style: CustomTheme.screenTitle,
                  ),
                  Text(AppContent.subTitleSettingsScreen,
                    style: CustomTheme.displayTextOne,
                  )
                ],
              ),
            ],
          )),
    );
  }

  //renderProfileWidget
  Widget _renderProfileWidget(double screnWidth, AuthService authService) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child:
      Stack(
        alignment: Alignment.center,
        children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Container(
            child: Padding(
              padding:
              const EdgeInsets.only(left: 20, top: 25, bottom: 25, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child:_image == null? Image.network(
                          widget.authUser.imageUrl,
                          width: 120,
                          height: 120,
                        ):Image.file(_image,width: 120,height: 120,fit: BoxFit.cover,),
                      ),
                      Positioned(
                        top: 0.0,
                        right: 0.0,
                        child: GestureDetector(
                            onTap: (){
                              getImage();
                            },
                            child: Container(
                              height: 30.0,
                              width: 30.0,
                              child: Icon(Icons.edit,color: CustomTheme.white,),
                              decoration: BoxDecoration(
                                color: CustomTheme.primaryColor,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                              ),
                            )),
                      ),
                    ],
                  ),
                  SizedBox(height: 34.0,),
                  EditTextUtils().getCustomEditTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: editProfileNameController,
                    prefixWidget: Padding(
                      padding: const EdgeInsets.only(left: 9),
                      child: Image.asset('assets/images/common/person.png', scale: 3,),
                    ),
                    style: CustomTheme.textFieldTitlePrimaryColored,
                  ),
                  SizedBox(height:25.0),

                  EditTextUtils().getCustomEditTextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: editProfileEmailController,
                    prefixWidget: Image.asset('assets/images/common/email.png', scale: 3),
                    style: CustomTheme.textFieldTitlePrimaryColored),
                  SizedBox(height: 25.0),
                  EditTextUtils().getCustomEditTextField(
                      keyboardType: TextInputType.number,
                      controller: editProfilePhoneController,
                      prefixWidget: Padding(
                        padding: const EdgeInsets.only(left: 9),
                        child: Image.asset('assets/images/common/edit_phone.png', scale: 3,),
                      ),
                      style: CustomTheme.textFieldTitlePrimaryColored
                  ),
                  SizedBox(height: 25,),
                  //gender textField
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(AppContent.selectGender,
                        style: CustomTheme.displayTextBoldPrimaryColor,
                      ),
                      //Use the above widget where you want the radio button
                      Row(
                        children: <Widget>[
                          addRadioButton(0, AppContent.maleText),
                          addRadioButton(1, AppContent.femaleText),
                          addRadioButton(2, AppContent.othersText),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 14.0),
                  //save changes button
                  GestureDetector(
                      onTap: () async {
                        /*print(widget.authUser.userId);*/
                        setState(() {isLoading = true;});
                        AuthUser user = AuthUser(
                            status: widget.authUser.status,
                            userId: widget.authUser.userId,
                            name: editProfileNameController.text.isNotEmpty
                                ? editProfileNameController.text
                                : widget.authUser.name,
                            email: editProfileEmailController.text.isNotEmpty
                                ? editProfileEmailController.text
                                : widget.authUser.email,
                            phone: editProfilePhoneController.text.isNotEmpty
                                ? editProfilePhoneController.value.text
                                : widget.authUser.phone,
                            meetingCode: widget.authUser.meetingCode,
                            imageUrl: widget.authUser.imageUrl,
                            gender: select,
                            role: widget.authUser.role,
                            joinDate: widget.authUser.joinDate,
                            lastLogin: widget.authUser.lastLogin);

                        updatedUser = await Repository().updateUserProfile(user, _image);
                        setState(() {isLoading = false;});
                        if(updatedUser != null){
                          authService.updateUser(updatedUser);
                          widget.profileUpdatedCallback();
                          if (this.mounted){
                            setState((){});
                          }
                        }
                      },
                      child: HelpMe().submitButton(screnWidth,AppContent.saveChanges))
                ],
              ),
            ),
            decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: CustomTheme.boxShadow,
              color: CustomTheme.white,
            ),
          ),
        ),
        if(isLoading)
          spinkit,
      ],
      ),
    );
  }
  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio(
          activeColor: CustomTheme.primaryColor,
          value: gender[btnValue],
          groupValue: select,
          onChanged: (value){
            setState(() {
              print(value);
              select=value;
            });
          },
        ),
        Text(title,style: CustomTheme.subTitleText,)
      ],
    );
  }

  Widget _renderAccountDeactiveWidget(double screnWidth,context) {
    return GestureDetector(
      onTap: (){
        showDialog(context: context,
        builder: (BuildContext context){
       return AlertDialog(
         title: new Text(AppContent.deactivateAccount),
         content:  accountDeactivateContent(),
         backgroundColor: Colors.white,
         shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
         actionsPadding: EdgeInsets.only(right: 15.0),
         actions: <Widget>[
           GestureDetector(
               onTap: (){
                 if(deactivateFormKey.currentState.validate())
                   accountDeactivate(context);
               },
               child: HelpMe().accountDeactivate(60, AppContent.yesText,height: 30.0)),
           GestureDetector(
               onTap: (){
                 cancelDeactivateAccount(context);
               },
               child: HelpMe().submitButton(60, AppContent.noText,height: 30.0)),
         ],
       );
        }
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(AppContent.ifYouWontUseYourAccount, style: CustomTheme.displayTextOne,
                ),
                SizedBox(height: 20.0),
                HelpMe().accountDeactivate(screnWidth, AppContent.deactivateAccount),
              ],
            ),
          ),
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: CustomTheme.boxShadow,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  //render accountDeactivate
  Widget accountDeactivateContent(){
    return Container(
      child: Form(
        key: deactivateFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(AppContent.doYouWantToProceed,
              style: CustomTheme.subTitleText,),
            SizedBox(height: 10.0,),
            EditTextUtils().getCustomEditTextField(
              prefixWidget: Container(width: 1.0,height: 1.0,),
              hintValue: AppContent.reasonText,
              maxLines: 2,
              keyboardType: TextInputType.multiline,
              controller: accountDeactivateReasonController,
              style: CustomTheme.subTitleTextColored,
              validator: (value){
                  return validateMinLength(value);
                }
            ),
            SizedBox(height: 10.0,),
            EditTextUtils().getCustomEditTextField(hintValue: AppContent.deleteConfirm,
              controller: deleteController,
              prefixWidget: Container(width: 5.0,height: 5.0,),
              style: CustomTheme.subTitleTextColored,
              validator: (value){
                  return validateDelete(value);
                }
            ),
          ],
        ),
      ),
    );
  }
  //accountDeactivate Function
  accountDeactivate(context)async{
    _accountDeactivate = await Repository().accountDeactivate(userId: widget.authUser.userId,reason: accountDeactivateReasonController.value.text);
    if(_accountDeactivate != null){
      if(_authService.getUser() != null)
        _authService.deleteUser();
      Navigator.of(context).pop();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyApp()),
      );
    }else{
       Navigator.of(context).pop();
    }
  }
  //cancel account deactivate
  Function cancelDeactivateAccount(context){
    deleteController.clear();
    accountDeactivateReasonController.clear();
    Navigator.of(context).pop();
  }
}
