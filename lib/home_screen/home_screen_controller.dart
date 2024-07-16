import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo21/api_provider/api_provider.dart';
import 'package:demo21/model/giphy_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<String> giphyList = <String>[].obs;
  RxList<String> trendingGiphyList = <String>[].obs;
  RxList<String> searchGiphyList = <String>[].obs;

  final firebase.FirebaseAuth _auth = firebase.FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _linkController = TextEditingController();

  Future<void> addLink({link}) async {
    firebase.User? user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).collection('links').add({'link': link});
    }
  }

  Stream<QuerySnapshot> getLinks() {
    firebase.User? user = _auth.currentUser;

    if (user != null) {
      return _firestore.collection('users').doc(user.uid).collection('links').snapshots();
    }
    throw Exception('User not logged in');
  }


  @override
  void onInit() {
    getTrendingGiphy();
    super.onInit();
  }

  void onTextChanged(String value) {
    if (value.length >= 3) {
      giphyList.value=[];
      searchGiphy(query: value);
    }
   else if (value.length == 0) {
      print("${trendingGiphyList.length}");
      searchGiphyList.value=[];
      giphyList=trendingGiphyList;
      getTrendingGiphy();
    }
  }

  Future<void> getTrendingGiphy() async {
    try {

      Giphy_Model giphyData = await ApiProvider.base().funLoadTrendingGiphy();
      if (giphyData.data != null && giphyData.data!.isNotEmpty) {
        trendingGiphyList.value = [];
        giphyList.value=[];
        giphyData.data!.forEach((giphyData) {
          trendingGiphyList.add(giphyData.images!.original!.url.toString());
        });
        giphyList=trendingGiphyList;
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> searchGiphy({query}) async {
    try {

      Giphy_Model giphyData = await ApiProvider.base().funSearchGiphy(querry: query);
      if (giphyData.data != null && giphyData.data!.isNotEmpty) {

        searchGiphyList.value = [];

        giphyData.data!.forEach((giphyData) {
          searchGiphyList.add(giphyData.images!.original!.url.toString());
        });
        giphyList=searchGiphyList;
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
