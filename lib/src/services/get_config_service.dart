import 'package:hive/hive.dart';
import 'package:spagreen/src/models/get_config_model.dart';
class GetConfigService{
  //Note getConfigService info
  var getConfigBox = Hive.box<GetConfigModel>('getConfigbox');
  //Note: add getConfigModel data
  void updateGetConfig(GetConfigModel getConfigModel)async{
    //print(getConfigModel.toJson().toString());
    await getConfigBox.put(0,getConfigModel);
  }
  //Note: appConfig data from phone
  AppConfig appConfig(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(0).appConfig : null;
  }
  //Note: appConfig data from phone
  AdsConfig adsConfig(){
    return getConfigBox.isNotEmpty ? getConfigBox.get(1).adsConfig : null;
  }

}
