import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:get/get.dart';

class FavouriteScreenController extends GetxController {
  RxList<String> giphyList = <String>[].obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>>? getLinks() {
    User? user = _auth.currentUser;

    if (user != null) {
      return _firestore.collection('users').doc(user.uid).collection('links').snapshots();
    }
    return null;
  }



  @override
  void onInit() {
    super.onInit();
  }



}
