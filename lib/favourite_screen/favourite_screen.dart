import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo21/favourite_screen/favourite_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FavouriteScreen extends GetView<FavouriteScreenController> {
  FavouriteScreen({Key? key}) : super(key: key);

  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Favourite'),
        ),
        body: SafeArea(
          bottom: false,
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.getLinks(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('No favourite added yet.'));
                }
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    return Container(
                        height: height * 0.35,
                        padding: const EdgeInsets.all(10),
                        child: Image.network(
                          doc['link'],
                          width: width,
                          fit: BoxFit.fill,
                        ));
                  }).toList(),
                );
              },
            ),
          ),
        ));
  }

  searchWidget() {
    return Container(
      child: Column(
        children: [
          Obx(() => controller.giphyList.isNotEmpty
              ? ListViewWidget()
              : centerLoadingWidget()),
          // SvgPicture.asset(Assets.mic),
        ],
      ),
    );
  }

  ListViewWidget() {
    return Expanded(
        child: Container(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: controller.giphyList.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var selected = false.obs;
                  return Container(
                      height: height * 0.35,
                      padding: const EdgeInsets.all(10),
                      child: Stack(children: [
                        Image.network(
                          controller.giphyList[index],
                          width: width,
                          fit: BoxFit.fill,
                        ),
                        Positioned(
                            right: 20,
                            top: 20,
                            child: Obx(() => InkWell(
                                onTap: () {},
                                child: Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                  size: 40,
                                ))))
                      ]));
                })));
  }

  centerLoadingWidget() {
    return Expanded(
        child: Container(
      // height: height * 0.78,
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: 8,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return shiummerEffect();
          }),
    ));
  }

  shiummerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        margin: EdgeInsets.all(10),
        width: width * 0.9,
        height: height * 0.30,
        color: Colors.black,
      ),
    );
  }
}
