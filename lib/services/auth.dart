import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final Firestore _db = Firestore.instance;

  // Firebase user one-time fetch
  User? get getUser => _auth.currentUser;

  // Firebase user a realtime stream
  Stream<User?> get user => _auth.authStateChanges();

  Future<User?> googleSignIn() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User? user =
          (await _auth.signInWithCredential(credential)).user;
      assert(!user!.isAnonymous);
      assert(await user!.getIdToken() != null);

      final User? currentUser = await _auth.currentUser!;
      assert(user!.uid == currentUser!.uid);

      //await updateUserData(user);

      print("user name: ${user!.displayName}");

      return user;
    } catch (error) {
      return null;
    }
  }

  // Future<void> addChatMessage(String chatRoomId, chatMessageData) {
  //   Firestore.instance
  //       .collection("chatroom")
  //       .document(chatRoomId)
  //       .collection("messages")
  //       .add(chatMessageData)
  //       .catchError((e) {
  //     print(e.toString());
  //   });
  // }
  //
  // void updateChatRoom(String chatRoomId, bool enabled) async {
  //   DocumentReference ref = _db.collection("chatroom")
  //       .document(chatRoomId);
  // }
  //
  // getChats(String chatRoomId) async {
  //   return await Firestore.instance
  //       .collection("chatroom")
  //       .document(chatRoomId)
  //       .collection("messages")
  //       .orderBy('timestamp')
  //       .snapshots();
  // }
  //
  // getUserChats(String uid) async {
  //   return await Firestore.instance
  //       .collection("chatroom")
  //       .where('users', arrayContains: uid)
  //       .snapshots();
  // }
  //
  // Future<DocumentReference> getUserNotifications(String uid) async {
  //   return await Firestore.instance
  //       .collection("notifications").document(uid);
  // }
  //
  // Future<QuerySnapshot> getAllBarterRequests(String uid) async {
  //   return await Firestore.instance
  //       .collection("barter_requests").where('usersList', arrayContains: uid).orderBy("updatedAt", descending: true)
  //       .getDocuments();
  // }
  //
  // Future<QuerySnapshot> getCreatedBarterRequests(String uid) async {
  //   return await Firestore.instance
  //       .collection("barter_requests").where('usersList', arrayContains: uid)
  //       .where("createdBy", isEqualTo: uid)
  //       .orderBy("updatedAt", descending: true)
  //       .getDocuments();
  // }
  //
  // Future<QuerySnapshot> getLatestBooks() async {
  //   return await Firestore.instance
  //       .collection('books')
  //       .orderBy('createdAt', descending: false)
  //       .limit(10)
  //       .getDocuments();
  // }
  //
  // Future<QuerySnapshot> getReceivedBarterRequests(String uid) async {
  //   return await Firestore.instance
  //       .collection("barter_requests").where('usersList', arrayContains: uid)
  //       .where("createdBy", isEqualTo: uid)
  //       .orderBy("updatedAt", descending: true)
  //       .getDocuments();
  // }
  //
  // // sign out
  // Future<void> signOut() async {
  //   try {
  //     await _googleSignIn.signOut();
  //     return await _auth.signOut();
  //   } catch (error) {
  //     print(error.toString());
  //     return null;
  //   }
  // }
  //
  // Future<bool> isSignedIn() async {
  //   return await _googleSignIn.isSignedIn();
  // }
  //
  // void updateUserData(FirebaseUser user) async {
  //   DocumentReference ref = _db.collection('users').document(user.uid);
  //   DocumentReference reportRef = _db.collection('reports').document(user.uid);
  //
  //   reportRef.setData({'uid': user.uid, 'lastActivity': DateTime.now()},
  //       merge: true);
  //
  //   ref.setData({
  //     'uid': user.uid,
  //     'email': user.email,
  //     'photoURL': user.photoUrl,
  //     'displayName': user.displayName,
  //     'lastSeen': DateTime.now()
  //   }, merge: true);
  // }
  //
  // Future<QuerySnapshot> findBookForUser(String user_id) async {
  //   return _db
  //       .collection('books')
  //       .where("usersList", arrayContains: user_id)
  //       .getDocuments();
  // }
  //
  // Future<QuerySnapshot> searchBookByGenre(String genre) async {
  //   return _db
  //       .collection('books')
  //       .where("genres", arrayContains: genre)
  //       .getDocuments();
  // }
  //
  // Future<QuerySnapshot> searchBookByText(List<String> searchList) async {
  //   return _db
  //       .collection('books').
  //       .where("searchParams", arrayContainsAny: searchList)
  //       .getDocuments();
  // }
  //
  // Future<bool> bookAlreadyExistsForUser(String isbn, String userId) async {
  //   return await _db
  //       .collection('books')
  //       .where("isbn", isEqualTo: isbn)
  //       .where("usersList", arrayContains: userId)
  //       .getDocuments()
  //       .then((onValue) {
  //     if (onValue != null) {
  //       return onValue.documents.length != 0;
  //     } else {
  //       return false;
  //     }
  //   });
  // }
  //
  // Future<bool> barterRequestAlreadyExists(String barterId) async {
  //   return await _db
  //       .collection('barter_requests')
  //       .document(barterId)
  //       .get()
  //       .then((value) {
  //     if (value.exists) {
  //       Status status = BarterRequest2.fromJson(value.data).status;
  //       if(status == Status.declined || status == Status.completed){
  //         return false;
  //       }
  //       return true;
  //     } // create the document
  //     else {
  //       return false;
  //     }
  //   });
  // }
  //
  // void addNewBook(BookDetailed book, User user) async {
  //   var bookRef = _db.collection('books').document(book.id);
  //   bookRef.get().then((onValue) {
  //     if (onValue.exists) {
  //       BookItem bookItem = BookItem.fromJson(onValue.data);
  //       if (!bookItem.usersList.contains(user.uid)) {
  //         bookItem.usersList.add(user.uid);
  //         bookItem.users.add(user);
  //         bookRef.setData(bookItem.toJson(), merge: true);
  //       }
  //     } // create the document
  //     else {
  //       BookItem bookItem = new BookItem(
  //           book.id,
  //           book.title,
  //           book.authors.join(","),
  //           book.imageLinks.thumbnail,
  //           book.averageRating,
  //           book.categories,
  //           [user.uid],
  //           [user],
  //           false,
  //           DateTime.now());
  //       bookRef.setData(bookItem.toJson(), merge: true); // create the document
  //     }
  //   });
  //   addNewGenre(book.categories);
  // }
  //
  // void addNewBarterRequest(BarterRequest2 barterRequest) async {
  //   var barterRef = _db
  //       .collection('barter_requests')
  //       .document(barterRequest.barterRequestId);
  //   barterRef.setData(barterRequest.toJson(), merge: false);
  // }
  //
  //
  // void addNewChatRoom(ChatRoomModel newchatRoom) async {
  //   var chatRoomRef = _db
  //       .collection('chatroom')
  //       .document(newchatRoom.chatRoomId);
  //   chatRoomRef.get().then((onValue) {
  //     if (onValue.exists) {
  //       ChatRoomModel chatRoom = ChatRoomModel.fromJson(onValue.data);
  //       chatRoom.lastMessage = newchatRoom.lastMessage;
  //       chatRoom.lastMessageReadBy = newchatRoom.lastMessageReadBy;
  //       chatRoom.lastMessageTime = newchatRoom.lastMessageTime;
  //     } // update the document
  //     else {
  //       chatRoomRef.setData(newchatRoom.toJson(), merge: false);
  //       //chatRoomRef.collection("messages").document().setData({});
  //       // create the document
  //     }
  //     Map<String, dynamic> chatMessageMap = {
  //       "user_id": newchatRoom.lastMessageReadBy,
  //       "message": newchatRoom.lastMessage,
  //       'timestamp': newchatRoom.lastMessageTime,
  //     };
  //     addChatMessage(newchatRoom.chatRoomId, chatMessageMap);
  //   });
  // }
  //
  // void updateBarterRequest(BarterRequest2 barterRequest) async {
  //   var barterRef = _db
  //       .collection('barter_requests')
  //       .document(barterRequest.barterRequestId);
  //   barterRef.setData(barterRequest.toJson(), merge: true);
  // }
  //
  // void addNewGenre(List<String> genres) async {
  //   for (String genre in genres) {
  //     _db
  //         .collection('genres')
  //         .document(genre)
  //         .setData({"name": genre, "iconURL": null}, merge: true);
  //   }
  // }
}
