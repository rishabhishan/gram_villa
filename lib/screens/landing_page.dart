import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gram_villa/themes/theme.dart';
import 'package:gram_villa/widgets/BottomNavigationBar/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage() : super();

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int currentIndex = 0;
  late User user;

  void onBottomIconPressed(int index) {
    setState(() {
      currentIndex = index;
    });
  }

//   @override
//   Widget build(BuildContext context) {
//     user = Provider.of<User>(context);
//
//     List<Widget> children = [
//       HomeScreen(),
//       HomeScreen(),
//       Container(),
//       HomeScreen(),
//       HomeScreen()
//     ];
//
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
// //         bottomNavigationBar: BottomNavBar(
// //           color: Colors.grey,
// //           selectedColor: kAccentColor,
// //           onTabSelected: _onTabSelected,
// //           selectedIndex: currentIndex,
// //           items: [
// //             BottomNavItem(icon: CupertinoIcons.home, iconLocation: "assets/icons/Home.svg",index: 0, press: (){}
// //             ),
// //             BottomNavItem(icon: CupertinoIcons.search, iconLocation: "assets/icons/Activity.svg", index: 1, press: (){}),
// //             BottomNavItem(icon: CupertinoIcons.add, press: (){ showModalBottomSheet(
// //               context: context,
// //               builder: (BuildContext context) => Scaffold(
// //                 body: Container(
// //                   padding: EdgeInsets.all(30),
// //                   child: Column(
// //                     children: <Widget>[
// //                       Text(
// //                         "Add New Book",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                             color: Colors.black,
// //                             fontSize: 24,
// //                             fontWeight: FontWeight.w600,
// //                             fontFamily: "Open-Sans"),
// //                       ),
// //                       Spacer(),
// //                       Center(
// //                         child: Image.asset(
// //                             "assets/images/icons8-barcode-scanner-100.png"),
// //                       ),
// //                       Spacer(),
// //                       Text(
// //                         "For safety reasons, we only accept books with ISBN. "
// //                             "You can find the ISBN barcode on the back cover of your book",
// //                         textAlign: TextAlign.center,
// //                         style: TextStyle(
// //                             color: Colors.black38,
// //                             fontSize: 16,
// //                             height: 1.5,
// //                             fontWeight: FontWeight.w600,
// //                             fontFamily: "Manrope"),
// //                       ),
// //                       Spacer(),
// //                       RaisedButton(
// //                         elevation: 5,
// //                         child: Text(
// //                           'Scan Barcode',
// //                           style: buttonTextStyle,
// //                         ),
// //                         shape: buttonBorder.scale(0.5),
// //                         padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
// //                         onPressed: () {
// //                           Navigator.pop(context);
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(builder: (context) {
// //                               return LoadingScreen();
// //                             }),
// //                           );
// //                         },
// //                         textColor: Colors.white,
// //                         color: kAccentColor,
// //                       )
// //                     ],
// //                   ),
// // //                actions: <Widget>[
// // //                  FlatButton(
// // //                    child: new Text("Scan Barcode"),
// // //                    onPressed: () {
// // //                      Navigator.push(
// // //                        context,
// // //                        MaterialPageRoute(builder: (context) {
// // //                          return AddNewBook(user: widget.firebaseUser);
// // //                        }),
// // //                      );
// // //                    },
// // //                  ),
// // //                ],
// //                 ),
// //               ),
// //             );}, iconLocation: ''),
// //             BottomNavItem(icon: CupertinoIcons.bell, iconLocation: "assets/icons/Chat.svg", index: 2, press: (){}),
// //             BottomNavItem(icon: CupertinoIcons.person, iconLocation: "assets/icons/Profile.svg", index: 3, press: (){}),
// //           ],
// //         ),
//         body: user == null? LoadingScreen():PageView(
//           physics: NeverScrollableScrollPhysics(),
//           controller: _pageController,
//           onPageChanged: (int page) {
//             setState(() {
//               currentIndex = page;
//             });
//           },
//           children: children,
//         ));
//   }


  @override
  Widget build(BuildContext context) {
    user = Provider.of<User>(context);

    List<Widget> children = [
      HomeScreen(),
      HomeScreen(),
      Container(),
      HomeScreen(),
      HomeScreen()
    ];
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                height: AppTheme.fullHeight(context) - 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xfffbfbfb),
                      Color(0xfff7f7f7),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //_appBar(),
                    //_title(),
                    Expanded(
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 300),
                        switchInCurve: Curves.easeInToLinear,
                        switchOutCurve: Curves.easeOutBack,
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: children[currentIndex],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: CustomBottomNavigationBar(
                onIconPresedCallback: onBottomIconPressed,
              ),
            )
          ],
        ),
      ),
    );
  }

}
