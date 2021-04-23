class MeetingHistoryList {
  final List<MeetingHistoryModel> meetingHistoryList;
  MeetingHistoryList({this.meetingHistoryList});

  factory MeetingHistoryList.fromJson(List<dynamic> persedJson){
    List<MeetingHistoryModel> meetingHistoryList = new List<MeetingHistoryModel>();
    meetingHistoryList = persedJson.map((i)=>MeetingHistoryModel.fromJson(i)).toList();

    return new MeetingHistoryList(
        meetingHistoryList: meetingHistoryList
    );
  }
}

class MeetingHistoryModel {
  String meetingHistoryId;
  String meetingCode;
  String nickName;
  String userId;
  String joinedAt;
  Null remarks;

  MeetingHistoryModel(
      {this.meetingHistoryId,
        this.meetingCode,
        this.nickName,
        this.userId,
        this.joinedAt,
        this.remarks});

  MeetingHistoryModel.fromJson(Map<String, dynamic> json) {
    meetingHistoryId = json['meeting_history_id'];
    meetingCode = json['meeting_code'];
    nickName = json['nick_name'];
    userId = json['user_id'];
    joinedAt = json['joined_at'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meeting_history_id'] = this.meetingHistoryId;
    data['meeting_code'] = this.meetingCode;
    data['nick_name'] = this.nickName;
    data['user_id'] = this.userId;
    data['joined_at'] = this.joinedAt;
    data['remarks'] = this.remarks;
    return data;
  }
}