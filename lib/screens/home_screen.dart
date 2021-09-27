import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gram_villa/models/category_model.dart';
import 'package:gram_villa/services/user_db.dart';
import 'package:gram_villa/widgets/loader.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../Constants.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Category> categories = [];
  bool isLoading = false;
  late User user;
  final Collection<Category> categoriesRef = Collection<Category>(path: 'categories');

  @override
  void initState() {
    fetchCategories();
    //fetchLatestBooks();
  }

  List<Color> categoryBgColors = [
    Color(0xFFc1cbd8),
    Color(0xFFee96b5),
    Color(0xFF929fb5),
    Color(0xFFffd3b6)
  ];


  fetchCategories() async {
    setState(() {
      isLoading = true;
    });
    categories = await categoriesRef.getData();
    setState(() {
      isLoading = false;
      categories = categories;
    });
  }
//
//   Future<Widget> fetchNotifications(String uid) async {
//     setState(() {
//       isLoading = true;
//     });
//     var data1;
//     await _authService.getUserNotifications(uid).then((value){
//       value.get().then((value) =>  data1 = value.data["type"]);
//     });
// //    List<UserNotification> notifications = doc.get().then((value) => null)  data['notifications'].map((value){
// //      UserNotification.fromJson(value);
// //    }).toList();
//     setState(() {
//       isLoading = false;
//     });
//   }
//
  Widget _buildCategoriesListItems(BuildContext context, int index) {
    var category = categories[index];
    var color = categoryBgColors[index % 4];
    return Material(
      //shadowColor: kShadowColor,
      child: InkWell(
        onTap: () {
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => SearchResultScreen(
          //           latestBooks: latestBooks,
          //           autoFocusSearch: false,
          //           genres:
          //           this.genres.map((genre) => genre['name']).toList(),
          //           searchGenre: genre["name"],
          //         )));
        },
        child: Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color,
            borderRadius: new BorderRadius.circular(borderRadius*2.5),
          ),
          child: Center(
            child: Text(category.displayName,
                softWrap: true,
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }

  Widget _buildLoadingCategoriesListItems(BuildContext context, int index) {
    var color = categoryBgColors[index % 4];
    return Material(
      child: Container(
        width: 100,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: new BorderRadius.circular(10.0),
        ),
      ),
    );
  }

// Future<Widget> fetchLatestBooks() async {
//   setState(() {
//     isLoading = true;
//   });
//   _authService.getLatestBooks().then((value){
//     setState(() {
//       isLoading = false;
//       latestBooks = value.documents.map((DocumentSnapshot docSnapshot){
//         return BookItem.fromJson(docSnapshot.data);
//       }).toList();
//     });
//   });

//    final QuerySnapshot result = await Firestore.instance
//        .collection('books')
//        .orderBy('createdAt', descending: false)
//        .limit(10)
//        .getDocuments();
//    final List<DocumentSnapshot> documents = result.documents;
//    setState(() {
//      isLoading = false;
//      latestBooks = documents.map((DocumentSnapshot docSnapshot){
//        return BookItem.fromJson(docSnapshot.data);
//      }).toList();
//    });
// }

Widget _buildLoadingBook(x, y) {
  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 91.0,
          height: 130.0,
          color: Colors.white,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
        ),
        Container(width: 90, height: 8.0, color: Colors.white),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
        ),
        Container(width: 91, height: 8.0, color: Colors.white)
      ]);
}
//
//   Widget _buildBook(BuildContext context, int index, List<BookItem> books) {
//     BookItem book = books[index];
//     return Material(
//       color: Colors.transparent,
//       child: InkWell(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) {
//               return BookDetailsV6Page(book: book);
//             }),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//
//             Material(
//               elevation: 5.0,
//               borderRadius: BorderRadius.all(Radius.circular(5)),
//               child: ClipRRect(
//                   borderRadius: BorderRadius.all(Radius.circular(5)),
//                   child: CachedNetworkImage(
//                     imageUrl: book.thumbnail,
//                     width: 98.0,
//                     height: 140.0,
//                     fit: BoxFit.fill,
//                     //height: 170,
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 12.0),
//               child: Container(
//                   width: 98,
//                   child: Text(
//                     book.title,
//                     overflow: TextOverflow.ellipsis,
//                     style: Theme.of(context).textTheme.subtitle.copyWith(
//                         color: Colors.black54, fontWeight: FontWeight.w600),
//                   )),
//             ),
//             Container(
//               padding: const EdgeInsets.only(top: 4.0),
//               width: 98,
//               child: Text(
//                 book.author,
//                 textScaleFactor: 0.9,
//                 overflow: TextOverflow.ellipsis,
//                 style: TextStyle(color: kLightBlackColor),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

@override
Widget build(BuildContext context) {
  user = Provider.of<User>(
      context);

  return Scaffold(
      resizeToAvoidBottomInset: false,
      //backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(child: (Container(
          padding: EdgeInsets.all(paddingScreen),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Hey ${this.user.displayName!.split(" ")[0]},",
                      style: kHeadingextStyle),
                  Material(
                    elevation: 5,
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    child: CircleAvatar(
                      backgroundImage:
                      NetworkImage(this.user.photoURL!),
                      backgroundColor: Colors.transparent,
                      radius: 25,
                    ),
                  ),
                ],
              ),
              //SizedBox(height: 20),

              Text("Find a book that you want to read",
                  style: kSubheadingextStyle),
              SizedBox(
                height: 36,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 4),
                decoration: BoxDecoration(
                  color: Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(borderRadius * 5),
                ),
                child: TextField(
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return LoadingScreen(
                        );
                      }),
                    );
                  },
                  decoration: InputDecoration(
                    //enabled: false,
                    hintText: "Search for titles, authors",
                    icon: SvgPicture.asset("assets/icons/search.svg"),
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 36),
              categories.length == 0
                  ? SizedBox.fromSize(
                size: const Size.fromHeight(45.0),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: _buildLoadingCategoriesListItems,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: 3)),
              )
                  : SizedBox.fromSize(
                size: const Size.fromHeight(45.0),
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: _buildCategoriesListItems,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 16,
                      );
                    },
                    itemCount: categories.length),
              ),
              SizedBox(height: 36),
              Text(
                "Newly Added Books",
                style: Theme
                    .of(context)
                    .textTheme
                    .subhead!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 12),
              categories.length == 0
                  ? SizedBox.fromSize(
                size: const Size.fromHeight(210.0),
                child: Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.grey,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: _buildLoadingBook,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: 3)),
              )
                  : SizedBox.fromSize(
                size: const Size.fromHeight(210.0),
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (BuildContext ctx, int index) {
                    return _buildLoadingBook(ctx, index);
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      width: 30,
                    );
                  },
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(top: 12.0),
                ),
              ),


//                Text(
//                  "Notifications",
//                  style: Theme.of(context)
//                      .textTheme
//                      .subhead
//                      .copyWith(fontWeight: FontWeight.w600),
//                ),
//                SizedBox(height: 12),
//                latestBooks.length == 0
//                    ? SizedBox.fromSize(
//                  size: const Size.fromHeight(210.0),
//                  child: Shimmer.fromColors(
//                      baseColor: Colors.grey[300],
//                      highlightColor: Colors.grey[100],
//                      child: ListView.separated(
//                          scrollDirection: Axis.horizontal,
//                          itemBuilder: _buildLoadingBook,
//                          separatorBuilder: (context, index) {
//                            return SizedBox(
//                              width: 20,
//                            );
//                          },
//                          itemCount: 3)),
//                )
//                    : SizedBox.fromSize(
//                  size: const Size.fromHeight(210.0),
//                  child: ListView.separated(
//                    itemCount: latestBooks.length,
//                    itemBuilder: (BuildContext ctx,int index){return _buildBook(ctx, index, latestBooks);},
//                    separatorBuilder: (context, index) {
//                      return SizedBox(
//                        width: 30,
//                      );
//                    },
//                    scrollDirection: Axis.horizontal,
//                    padding: const EdgeInsets.only(top: 12.0),
//                  ),
//                ),
            ],
          ),
        )),
        ),
      ));
}}
