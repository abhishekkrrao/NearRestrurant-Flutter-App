import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eshop/src/component/SliderCell.dart';
import 'package:eshop/src/model/RestModel.dart';
import 'package:eshop/src/model/Slider.dart';
import 'package:eshop/src/service/service.dart';
import 'package:flutter/material.dart';

class Restrurent extends StatefulWidget {
  @override
  RestrurentState createState() => RestrurentState();
}

class RestrurentState extends State<Restrurent> {
  final ScrollController _scrollController = ScrollController();
  List<SliderModel> arrayList;
  List<RestModel> arrayListGrid;
  double _current = 0;
  List<String> imageList = [
    "assets/Icons/utilicon/f1.jpg",
    "assets/Icons/utilicon/f2.jpg",
    "assets/Icons/utilicon/f3.jpg"
  ];

  @override
  initState() {
    super.initState();
    initValue();
  }

  void initValue() async {
    Future<List<SliderModel>> list = Services.getSliderJson();
    arrayList = await list;
    Future<List<RestModel>> listGrid = Services.getJson();
    arrayListGrid = await listGrid;
  }

  List<Widget> getPageList(List<String> image) {
    var listView = List<Widget>();
    List.generate(
        image.length, (index) => {listView.add(SlderCell(image[index]))});
    return listView;
  }

  @override
  Widget build(BuildContext context) {
    return ViewIt();
  }

  // ignore: non_constant_identifier_names
  Widget ViewIt() {
    return Scaffold(
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              child: CarouselSlider(
                options: CarouselOptions(
                    aspectRatio: 16 / 9,
                    viewportFraction: .8,
                    initialPage: 0,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    onPageChanged: (pos, op) {
                      setState(() {
                        _current = pos.toDouble();
                      });
                    }),
                items: getPageList(imageList),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              width: double.infinity,
              child: DotsIndicator(
                dotsCount: imageList.length,
                position: _current,
                decorator: DotsDecorator(
                  // activeColor: Color(int.parse("0xFF003975")),
                  activeColor: Colors.green,
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text("Meal",style: TextStyle(fontSize: 21),),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 110.0,
              width: 110.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (arrayList[index] != null) {
                    return singleView(arrayList[index]);
                  }
                  return CircularProgressIndicator();
                },
                itemCount: arrayList == null ||
                        (arrayList.length == null || arrayList.length == 0)
                    ? 0
                    : arrayList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text("Top Restrurent",style: TextStyle(fontSize: 21),),
            ),
          ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (arrayListGrid[index] != null) {
                  return singleGridView(arrayListGrid[index]);
                }
                return CircularProgressIndicator();
              },
              childCount: arrayListGrid == null ||
                      (arrayListGrid.length == 0 ||
                          arrayListGrid.length == null)
                  ? 0
                  : arrayListGrid.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget singleGridView(RestModel restModel) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Image(
              image: AssetImage(restModel.icon),
              width: double.infinity,
              height: 120,
              fit: BoxFit.fill,
            ),
            Text(restModel.title),
          ],
        ),
      ),
    );
  }



  Widget singleView(SliderModel sliderModel) {
    return SizedBox(
      width: 100,
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        color: Colors.white,
        child: Column(
          children: [
           Padding(
             padding: EdgeInsets.all(5.0),
             child:  ClipRRect(
               borderRadius:BorderRadius.circular(5),
               child:Image(
                 image: AssetImage(sliderModel.icon),
                 height: 66.0,
                 width: 66,
                 fit: BoxFit.fill,
               ),
             ),
           ),
            Text(sliderModel.title),
          ],
        ),
      ),
    );
  }
}
