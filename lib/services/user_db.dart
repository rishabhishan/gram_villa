import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'globals.dart';

// class UserDatabaseService {
//   final String uid;
//
//   UserDatabaseService({this.uid});
//
//   // collection reference
//   final CollectionReference userCollection =
//       Firestore.instance.collection('users');
//
//   Future<void> updateUserData(User user) async {
//     return await userCollection.document(uid).setData(user.toJson());
//   }
//
//   // user data from snapshots
//   User _userDataFromSnapshot(DocumentSnapshot snapshot) {
//     return User.fromJson(snapshot.data);
//   }
//
//   // get user doc stream
//   Stream<User> get userData {
//     return userCollection.document(uid).snapshots().map(_userDataFromSnapshot);
//   }
// }

class Collection<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late CollectionReference ref;

  Collection({required this.path}) {
    ref = _db.collection(path);
  }

  Future<List<T>> getData() async {
    var snapshots = await ref.get();
    return snapshots.docs
        .map((doc) => Global.models[T](doc.data) as T)
        .toList();
  }

  Stream<List<T>> streamData() {
    return ref.snapshots().map(
            (snapshot) => snapshot.docs.map((DocumentSnapshot document) {
          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
          return Global.models[T](data) as T;
        }).toList());
  }
}

// class UserData<T> {
//   final Firestore _db = Firestore.instance;
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final String collection;
//
//   UserData({this.collection});
//
//   Stream<T> get documentStream {
//     _auth.onAuthStateChanged.map((user) {
//       if (user != null) {
//         Document<T> doc = Document<T>(path: '$collection/${user.uid}');
//         return doc.streamData();
//       } else {
//         return Stream<T>.value(null);
//       }
//     });
//   }
//
//   Future<T> getDocument() async {
//     FirebaseUser user = await _auth.currentUser();
//
//     if (user != null) {
//       Document doc = Document<T>(path: '$collection/${user.uid}');
//       return doc.getData();
//     } else {
//       return null;
//     }
//   }
//
//   Future<void> upsert(Map data) async {
//     FirebaseUser user = await _auth.currentUser();
//     Document<T> ref = Document(path: '$collection/${user.uid}');
//     return ref.upsert(data);
//   }
// }

class Document<T> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String path;
  late DocumentReference ref;

  Document({required this.path}) {
    ref = _db.doc(path);
  }

  Future<T> getData() {
    return ref.get().then((v) => Global.models[T](v.data) as T);
  }

  Stream<T> streamData() {
    return ref.snapshots().map((v) => Global.models[T](v.data) as T);
  }

  Future<void> upsert(Map data) {
    return ref.set(Map<String, dynamic>.from(data));
  }
}
