import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gram_villa/services/auth.dart';
import 'package:gram_villa/widgets/loader.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../Constants.dart';
import 'landing_page.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AuthService _authService = new AuthService();
  late User user;

  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    //isSignedIn();
  }

  void isSignedIn() async {
    setState(() {
      isLoading = true;
    });

    if (_authService.getUser != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) {
              return LandingPage();
            },
            settings: RouteSettings(name: "/landing")),
      );
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Widget> buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    list.add(optionButton());
    return list;
  }

  Widget optionButton() {
    return _currentPage != _numPages - 1
        ? Expanded(
            child: Container(
              height: curvedButtonHeight,
              alignment: Alignment.centerRight,
              child: FlatButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _numPages - 1,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          )
        : Expanded(
            child: Container(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //_tryItButtonUI,
                    _loginWithGoogleButtonUI
                  ],
                )),
          );
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 10,
      width: isActive ? 12 : 12,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xFF7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  Widget get _loginWithGoogleButtonUI => ButtonTheme(
        height: curvedButtonHeight,
        child: OutlineButton.icon(
          icon: Icon(
            LineAwesomeIcons.google_plus,
            color: Colors.white,
          ),
          borderSide: BorderSide(color: Colors.white),
          onPressed: navigateToLandingPage,
          textColor: Colors.white,
          label: Text('Login with Google'),
          shape: StadiumBorder(),
        ),
      );

  Future<void> navigateToLandingPage() async {
    setState(() {
      isLoading = true;
    });
    var result = await _authService.googleSignIn();
    if (result != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) {
          return LandingPage();
        }),
      );
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = true;
      });
    }
  }

  Widget getOnboardingScreen(image, title, subtitle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Image(
            image: AssetImage(
              image,
            ),
            height: 300.0,
            width: 300.0,
          ),
        ),
        SizedBox(height: 20),
        Text(
          title,
          style: kTitleStyle,
        ),
        SizedBox(height: 20),
        Text(
          subtitle,
          style: kSubtitleStyle,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    //ScreenUtil.init(height: 1080, width: 2160, allowFontScaling: true);
    return isLoading
        ? LoadingScreen()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.4, 0.7, 0.9],
                  colors: [
                    Color(0xFF3594DD),
                    Color(0xFF4563DB),
                    Color(0xFF5036D5),
                    Color(0xFF5B16D0),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(paddingScreen),
                  child: Stack(children: [
                    PageView(
                      physics: BouncingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: <Widget>[
                        getOnboardingScreen(
                            'assets/images/onboarding0.png',
                            'Explore',
                            'Search for books available in your locality'),
                        getOnboardingScreen(
                            'assets/images/onboarding1.png',
                            'Exchange',
                            'Barter your book with someone who needs your books'),
                        getOnboardingScreen(
                            'assets/images/onboarding2.png',
                            'Return',
                            'Return the book after an agreed upon time')
                      ],
                    ),
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: buildPageIndicator(),
                        )),
                  ]),
                ),
              ),
            ),
          );
  }
}
