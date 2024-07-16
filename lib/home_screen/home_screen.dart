import 'package:demo21/authentication/auth_controller.dart';
import 'package:demo21/favourite_screen/favourite_screen.dart';
import 'package:demo21/favourite_screen/favourite_screen_controller.dart';
import 'package:demo21/home_screen/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends GetView<HomeScreenController> {
  HomeScreen({Key? key}) : super(key: key);
  final AuthController authController = Get.put(AuthController());
  var height, width;

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('Home'),
          actions: [
            IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {
                Get.lazyPut<FavouriteScreenController>(() => FavouriteScreenController(),);
                Get.to(FavouriteScreen());
                // authController.signOut();
              },
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authController.signOut();
              },
            ),
          ],
        ),
        body: SafeArea(bottom: false, child: searchWidget()));
  }

  searchWidget() {
    return Container(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                      controller: controller.searchController,
                      style: const TextStyle(
                          fontSize: 17.0, fontWeight: FontWeight.w400),
                      onChanged: controller.onTextChanged,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        hintStyle: TextStyle(),
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(20, 4, 20, 8),
                      )),
                ),
                InkWell(
                    onTap: () {
                      controller.searchGiphy(
                          query: controller.searchController.text);
                    },
                    child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Icon(Icons.search))),
              ],
            ),
          ),
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
                            child: Obx(()=>InkWell(
                                onTap: () {
                                 if( selected.value == false){
                                  controller.addLink(
                                  link : controller.giphyList[index]);
                                  selected.value=true;
                                }
                                },
                                child: Icon(
                                  selected.value == true
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: selected == true? Colors.red:Colors.white,
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
