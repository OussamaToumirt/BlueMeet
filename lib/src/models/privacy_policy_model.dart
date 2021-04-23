class PrivacyPolicyModel {
  String status;
  String privacyPolicyText;

  PrivacyPolicyModel({this.status, this.privacyPolicyText});

  PrivacyPolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    privacyPolicyText = json['privacy_policy_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['privacy_policy_text'] = this.privacyPolicyText;
    return data;
  }
}