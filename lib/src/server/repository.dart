import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:spagreen/src/models/account_deactivate.dart';
import 'package:spagreen/src/models/get_config_model.dart';
import 'package:spagreen/src/models/meeting_history_model.dart';
import 'package:spagreen/src/models/meeting_mode.dart';
import 'package:spagreen/src/models/password_reset_model.dart';
import 'package:spagreen/src/models/privacy_policy_model.dart';
import 'package:spagreen/src/models/user_model.dart';
import 'package:spagreen/src/utils/validators.dart';
import '../../config.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class Repository {
  Dio dio = Dio();
  //Note: Retrive app config from server
  Future<GetConfigModel> getAppConfig() async {
    try {
      final response = await dio.get("${Config.baseUrl}/api/v100/config?API-KEY=${Config.apiKey}");
      if (response.statusCode == 200) {
        GetConfigModel getConfigModel = GetConfigModel.fromJson(response.data);
        return getConfigModel;
      }
    } catch (ex) {
      return null;
    }
  }
  //getLoginAuthUser from api after successfuall login
  Future<AuthUser> getLoginAuthUser(String email, String password) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({
      "email": email,
      "password": password,
    });
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/login", data: formData);
      AuthUser user = AuthUser.fromJson(response.data);
      if (user.status == 'success') {
        return user;
      } else {
        showShortToast(response.data['data']);
        print(response.data);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //User Registration
  Future<AuthUser> getRegistrationAuthUser(
      String name, String email, String password) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"name": name, "email": email, "password": password,});
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/signup", data: formData);
      AuthUser user = AuthUser.fromJson(response.data);
      if (user.status == 'success') {
        return user;
      } else {
        showShortToast(response.data['data']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
  ///Firebase Auth User
  Future<AuthUser> getFirebaseAuthUser({@required String uid,String email, String phone,}) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"uid": uid, "email": email, "phone": phone,
    });
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/firebase_auth", data: formData);
      AuthUser user = AuthUser.fromJson(response.data);
      if (user.status == 'success') {
        return user;
      } else {
        showShortToast(response.data['message']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //update user info
  Future<AuthUser> updateUserProfile(AuthUser user,File image) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"name": user.name, "email": user.email, "phone": user.phone, "gender": user.gender, "id": user.userId, "photo":image != null? await MultipartFile.fromFile(image.path):null,
    });
    try {
      final response =
          await dio.post("${Config.baseUrl}/api/v100/update_profile", data: formData);
      AuthUser updateAuthUser =  AuthUser.fromJson(response.data);
      if (updateAuthUser.status == 'success') {
        showShortToast(updateAuthUser.status);
        return updateAuthUser;
      } else {
        showShortToast(response.data['data']);
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Getting Meeting History by ID
  Future<List<MeetingHistoryModel>> meetingHistory(String userId,String pageIndex) async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    try {
      final response = await dio.get("${Config.baseUrl}api/v100/meeting_history_by_user_id?user_id=$userId&page=$pageIndex");
      if (response.statusCode == 200) {
        List<MeetingHistoryModel> meetingHistoryList = MeetingHistoryList.fromJson(response.data).meetingHistoryList;
        return meetingHistoryList;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //Getting Meeting History by ID
  static Future<List<MeetingHistoryModel>> meetingHistoryPagination(String userId,String pageIndex) async {
    Dio dio = Dio();
    dio.options.headers = {"API-KEY": Config.apiKey};
    try {
      final response = await dio.get("${Config.baseUrl}api/v100/meeting_history_by_user_id?user_id=$userId&page=$pageIndex");
      if (response.statusCode == 200) {
        List<MeetingHistoryModel> meetingHistoryList = MeetingHistoryList.fromJson(response.data).meetingHistoryList;
        return meetingHistoryList;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<MeetingModel> joinMeeting({String meetingCode, String userId,String nickName})async{
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"meeting_code":meetingCode, "user_id": userId, "nick_name": nickName});
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/join_meetting/",data: formData);
      MeetingModel joinResponse = MeetingModel.fromJson(response.data);
      if(joinResponse.status == 'success'){
        return joinResponse;
      } else {
        showShortToast(response.data['message']);
        return null;
      }
    }catch (e){
      print(e);
      return null;
    }
  }

  Future<MeetingModel> hostMeeting({String meetingCode, String userId,String meetingTitle})async{
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"meeting_code":meetingCode, "user_id": userId, "meeting_title": meetingTitle,});
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/create_and_join_meetting/",data: formData);
      MeetingModel joinResponse = MeetingModel.fromJson(response.data);
      if(joinResponse.status == 'success'){
        return joinResponse;
      }
    }catch (e){
      print(e);
      return null;
    }
  }

  Future<AccountDeactivate> accountDeactivate({String userId,String reason})async{
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"id":userId, "reason": reason,});
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/deactivate_account/",data: formData);
      AccountDeactivate deactivate = AccountDeactivate.fromJson(response.data);
      showShortToast(deactivate.data);
      if(deactivate.status == 'success'){
        return deactivate;
      }
    }catch (e){
      print(e);
      return null;
    }
  }

  //privacyPolicy Response
  Future<PrivacyPolicyModel> privacyPolicyResponse() async {
    dio.options.headers = {"API-KEY": Config.apiKey};
    try {
      final response = await dio.get("${Config.baseUrl}api/v100/privacy_policy");
      if (response.statusCode == 200) {
        PrivacyPolicyModel meetingHistoryList = PrivacyPolicyModel.fromJson(response.data);
        return meetingHistoryList;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  //passwordResetResponse
  Future<PasswordResetModel> passResetResponse({String email})async{
    dio.options.headers = {"API-KEY": Config.apiKey};
    FormData formData = new FormData.fromMap({"email":email});
    try {
      final response = await dio.post("${Config.baseUrl}/api/v100/password_reset/",data: formData);
      PasswordResetModel passwordResetModel = PasswordResetModel.fromJson(response.data);
      if(passwordResetModel.status == 'success'){
        return passwordResetModel;
      }
    }catch (e){
      print(e);
      return null;
    }
  }
}
