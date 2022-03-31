import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guilt_app/constants/assets.dart';
import 'package:guilt_app/constants/colors.dart';
import 'package:guilt_app/ui/login/welcome_login.dart';
import 'package:guilt_app/utils/device/device_utils.dart';
import 'package:guilt_app/utils/routes/routes.dart';
import 'package:guilt_app/widgets/rounded_button_widget.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  var activeScreen = 0;

  void _onIntroEnd(context) {
    Routes.navigateToScreen(context, Routes.welcome_login);
  }

  _getGloabalHeader() {
    return AppBar(
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      leading: (activeScreen == 0
          ? Text('')
          : Align(
              alignment: Alignment.topRight,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () => introKey.currentState?.animateScroll(activeScreen -1),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0, right: 16),
                    child: Icon(
                      Icons.arrow_back_ios_outlined,
                      color: Colors.black,
                      size: 15,
                    ),
                  ),
                ),
              ),
            )),
      actions: [
        (activeScreen == 2
            ? Text('')
            : Align(
                alignment: Alignment.topRight,
                child: SafeArea(
                  child: GestureDetector(
                    onTap: () => _onIntroEnd(context),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, right: 16),
                      child: Text(
                        'Skip',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                ),
              ))
      ],
    );
  }

  Widget _buildImage(String assetName) {
    return Container(
        width: DeviceUtils.getScaledWidth(context, 0.50),
        height: DeviceUtils.getScaledHeight(context, 0.25),
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(
              Assets.appIcon,
            ),
            fit: BoxFit.contain,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.transparent,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: AppColors.pageBackgroundColor,
      // globalHeader: activeScreen == 2 ? Text('Go Back'):Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: GestureDetector(
      //       onTap: ()=> _onIntroEnd(context),
      //       child: Padding(
      //         padding: const EdgeInsets.only(top: 16.0, right: 16),
      //         child: Text('Skip'),
      //       ),
      //     ),
      //   ),
      // ),
      globalHeader: _getGloabalHeader(),
      onChange: (page) {
        print(page);
        setState(() {
          activeScreen = page;
        });
      },
      pages: [
        PageViewModel(
          title: null,
          titleWidget: Text(
            'First',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          image: _buildImage('img1.jpg'),
          footer: ElevatedButtonWidget(
            buttonColor: Theme.of(context).primaryColor,
            buttonText: 'Next',
            onPressed: () {
              introKey.currentState?.animateScroll(1);
            },
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: null,
          titleWidget: Text(
            'Second',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          image: _buildImage('img2.jpg'),
          footer: ElevatedButtonWidget(
            buttonColor: Theme.of(context).primaryColor,
            buttonText: 'Next',
            onPressed: () {
              introKey.currentState?.animateScroll(2);
            },
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: null,
          titleWidget: Text(
            'Third',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
          image: _buildImage('img3.jpg'),
          footer: ElevatedButtonWidget(
            buttonColor: Theme.of(context).primaryColor,
            buttonText: 'Get Started',
            onPressed: () {
              _onIntroEnd(context);
            },
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showNextButton: false,
      showDoneButton: false,
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.grey,
        activeSize: Size(10.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
