import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/user_model.dart';

class UserRepo {
  late String currentUserID;
  late FirebaseFirestore mFireStore;

  UserRepo() {
    mFireStore = FirebaseFirestore.instance;
    currentUserID = FirebaseAuth.instance.currentUser!.uid;
  }

  // -- Current User Data
  Future<UserModel> getCurrentUser() async {
    UserModel currentUserData = UserModel();
    final userDoc =
        await mFireStore.collection('Users').doc(currentUserID).get();
    if (userDoc.exists) {
      currentUserData = UserModel.fromMap(userDoc.data()!);
    }

    return currentUserData;
  }

  // -- All Users Data
  Future<List<UserModel>> getAllUsers() async {
    List<UserModel> userList = [];
    final querySnapshot = await mFireStore.collection('Users').get();
    final usersMapList = querySnapshot.docs;
    if (usersMapList.isNotEmpty) {
      userList =
          usersMapList.map((user) => UserModel.fromMap(user.data())).toList();
    }

    return userList;
  }

 
}
