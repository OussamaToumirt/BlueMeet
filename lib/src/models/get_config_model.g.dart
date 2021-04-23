// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_config_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetConfigModelAdapter extends TypeAdapter<GetConfigModel> {
  @override
  final typeId = 0;

  @override
  GetConfigModel read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetConfigModel(
      appConfig: fields[0] as dynamic,
      adsConfig: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, GetConfigModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.appConfig)
      ..writeByte(1)
      ..write(obj.adsConfig);
  }
}

class AppConfigAdapter extends TypeAdapter<AppConfig> {
  @override
  final typeId = 1;

  @override
  AppConfig read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppConfig(
      appName: fields[0] as dynamic,
      appMode: fields[1] as dynamic,
      jitsiServer: fields[2] as dynamic,
      meetingPrefix: fields[3] as dynamic,
      mandatoryLogin: fields[4] as dynamic,
      allowUnauthorizedMeetingCode: fields[5] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AppConfig obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.appName)
      ..writeByte(1)
      ..write(obj.appMode)
      ..writeByte(2)
      ..write(obj.jitsiServer)
      ..writeByte(3)
      ..write(obj.meetingPrefix)
      ..writeByte(4)
      ..write(obj.mandatoryLogin)
      ..writeByte(5)
      ..write(obj.allowUnauthorizedMeetingCode);
  }
}

class AdsConfigAdapter extends TypeAdapter<AdsConfig> {
  @override
  final typeId = 2;

  @override
  AdsConfig read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdsConfig(
      adsEnable: fields[0] as dynamic,
      mobileAdsNetwork: fields[1] as dynamic,
      admobAppId: fields[2] as dynamic,
      admobBannerAdsId: fields[3] as dynamic,
      admobInterstitialAdsId: fields[4] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, AdsConfig obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.adsEnable)
      ..writeByte(1)
      ..write(obj.mobileAdsNetwork)
      ..writeByte(2)
      ..write(obj.admobAppId)
      ..writeByte(3)
      ..write(obj.admobBannerAdsId)
      ..writeByte(4)
      ..write(obj.admobInterstitialAdsId);
  }
}
