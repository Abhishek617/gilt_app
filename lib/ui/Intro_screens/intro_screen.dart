import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => HomePage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Abhishek'),
      ),
      body: Container(),
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.network("https://cdn.iconscout.com/icon/free/png-64/working-hour-1605692-1361041.png");
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.white,
      globalHeader: Align(
        alignment: Alignment.topRight,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16),
            child: Text('Skip'),
          ),
        ),
      ),




      pages: [
        PageViewModel(
          title: "Hello Dear",
          body:
          "Instead of having to buy an entire share, invest any amount you want.",
          image: _buildImage('img1.jpg'),

          footer: Container(
            height: 35,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(1);
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(

                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Master's",
          body:
          "Download the Stockpile app and master the market with our mini-lesson.",
          image: _buildImage('img2.jpg'),
          footer: Container(
            height: 35,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(2);
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(

                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Hello Php dots",
          body:
          "Kids and teens can track their stocks 24/7 and place trades that you approve.",
          image: _buildImage('img3.jpg'),
          footer: Container(
            height: 35,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(3);
              },
              child: const Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(

                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('img2.jpg'),
          footer: Container(
            height: 35,
            width: 250,
            child: ElevatedButton(
              onPressed: () {
                introKey.currentState?.animateScroll(0);
              },
              child: const Text(
                'Go To First',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          decoration: pageDecoration,
        ),
        //PageViewModel(
         // title: "Title of last page - reversed",
         // bodyWidget: Row(
          //  mainAxisAlignment: MainAxisAlignment.center,
          //  children: const [
            //  Text("Click on ", style: bodyStyle),
            //  Icon(Icons.edit),
             // Text(" to edit a post", style: bodyStyle),
           // ],
         // ),
         // decoration: pageDecoration.copyWith(
           // bodyFlex: 2,
         //   imageFlex: 4,
          //  bodyAlignment: Alignment.bottomCenter,
           // imageAlignment: Alignment.topCenter,
         // ),
         // image: _buildImage('img1.jpg'),
         // reverse: true,
       // ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: true,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.white70,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );

  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(child: Text("This is the screen after Introduction")),
    );
  }
}