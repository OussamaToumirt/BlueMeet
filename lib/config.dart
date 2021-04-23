class Config {
  // copy your api url from php admin dashboard & paste below
  static final String baseUrl = "https://meet.digital-sell.com/";
  //copy your api key from php admin dashboard & paste below
  static final String apiKey  = "ce65508b1a5ffb4";
  //
  static final String oneSignalAppID = "66c7e2ec-3962-4a99-8d91-d4f564b5eda9";

  static final bool enableFacebookAuth = true;
  static final bool enableGoogleAuth = true;
  static final bool enablePhoneAuth = true;
  static final bool enableAppleAuthForIOS = true;
}

/// the welcome screen data
List introContent = [
  {
    "title": "Welcome To",
    "image": "assets/images/introImage/intro_slide_one.png",
    "desc": "Start or join a video meeting on the go"
  },
  {
    "title": "Message Your Team",
    "image": "assets/images/introImage/intro_slide_one.png",
    "desc": "Send text, voice message and share file"
  },
  {
    "title": "Get BlueMeet",
    "image": "assets/images/introImage/intro_slide_one.png",
    "desc": "Work anywhere, with anyone, one any device"
  }
];