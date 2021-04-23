import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:spagreen/config.dart' as config;
import 'package:spagreen/src/screen/sign_up_screen.dart';
import 'package:spagreen/src/strings.dart';
import 'package:spagreen/src/style/theme.dart';
import '../button_widget.dart';
import 'main_screen.dart';
class OnBoardScreen extends StatefulWidget {
  final bool isMandatoryLogin;
  const OnBoardScreen({Key key,@required this.isMandatoryLogin}) : super(key: key);

  @override
  _OnBoardScreenState createState() => _OnBoardScreenState();
}

class _OnBoardScreenState extends State<OnBoardScreen> {
  final List<Slide> slides = [];
  List<Widget> tabs = new List();

  @override
  void initState() {
    for (int i = 0; i < config.introContent.length; i++) {
      Slide slide = Slide(
        title: config.introContent[i]['title'],
        description: config.introContent[i]['desc'],
        marginTitle: EdgeInsets.only(
          top: 100.0,
          bottom: 50.0,
        ),
        maxLineTextDescription: 2,
        styleTitle: CustomTheme.screenTitle,
        backgroundColor: Colors.white,
        marginDescription: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
        styleDescription: CustomTheme.displayTextBoldBlackColor,
        foregroundImageFit: BoxFit.fitWidth,
      );

      slide.pathImage = config.introContent[i]['image'];
      slides.add(slide);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      shouldHideStatusBar: true,
      colorActiveDot: CustomTheme.primaryColor,
      isShowSkipBtn: true,
      isShowPrevBtn: true,
      slides: slides,
      backgroundColorAllSlides: Colors.white,
      styleNameSkipBtn: CustomTheme.subTitleTextColored,
      styleNameDoneBtn: CustomTheme.subTitleTextColored,
      listCustomTabs: this.renderListCustomTabs(),
      nameNextBtn: AppContent.nextButton,
      namePrevBtn: AppContent.preButton,
      nameDoneBtn: AppContent.signup,
      onDonePress: () async {
        await Navigator.pushNamed(context, SignUpScreen.route);
      },
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = new List();
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        width: double.infinity,
        height: double.infinity,
        child: Container(
          margin: EdgeInsets.only(bottom: 60.0, top: 60.0),
          child: ListView(
            children: <Widget>[
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0,bottom: 100.0),
              ),
              Container(
                child: GestureDetector(
                    child: Image.asset(
                      currentSlide.pathImage,
                      width: 200.0,
                      height: 200.0,
                      fit: BoxFit.contain,
                    )),
              ),
              if(!widget.isMandatoryLogin && i == 2)
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pushReplacementNamed(context, MainScreen.route);
                    },
                    child: HelpMe().submitButton(300, AppContent.joinMeeting),
                  ),
                )
            ],
          ),
        ),
      ));
    }
    return tabs;
  }
}
