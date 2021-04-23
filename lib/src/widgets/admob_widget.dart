import 'dart:io';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:spagreen/src/models/get_config_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdmobWidget extends StatelessWidget {
  AdsConfig adsConfig;
   AdmobWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  ValueListenableBuilder(
      valueListenable: Hive.box<GetConfigModel>('getConfigbox').listenable(),
      builder: (context,box,widget) {
        adsConfig =  box.get(0).adsConfig;

        return adsConfig.adsEnable? Container(
          width: MediaQuery.of(context).size.width,
          child:  Container(
            margin: EdgeInsets.only(bottom: 20.0),
            child: AdmobBanner(
              adUnitId: getBannerAdUnitId(adsConfig.admobBannerAdsId),
              adSize: AdmobBannerSize.BANNER,
            ),
          ),
        ) : Container(height: 0.0,width: 0.0,);
      },
    );
  }

  String getBannerAdUnitId(String adsMobBannerId) {
    //print(adsMobBannerId);
    if (Platform.isIOS) {
      return adsMobBannerId;
    } else if (Platform.isAndroid) {
      return adsMobBannerId;
    }
    return null;
  }
}
