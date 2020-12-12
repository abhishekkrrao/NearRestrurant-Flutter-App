import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:eshop/src/component/SliderCell.dart';
import 'package:eshop/src/model/RestModel.dart';
import 'package:eshop/src/model/Slider.dart';
import 'package:eshop/src/pages/ChoosePayment.dart';
import 'package:eshop/src/service/service.dart';
import 'package:eshop/src/themes/theme.dart';
import 'package:flutter/material.dart';
class Restrurent extends StatefulWidget {
  @override
  RestrurentState createState() => RestrurentState();
}
class RestrurentState extends State<Restrurent> {
  final ScrollController _scrollController = ScrollController();
  List<SliderModel> arrayList;
  List<RestModel> arrayListGrid = [];
  double _current = 0;
  List<String> imageList = [
    "assets/Icons/utilicon/f1.jpg",
    "assets/Icons/utilicon/f2.jpg",
    "assets/Icons/utilicon/f3.jpg"
  ];
  @override
  initState() {
    super.initState();
    initValue().then((value) => { setState(() {arrayList = value;})});
    initGrid().then((value) => { setState(() {arrayListGrid = value;})});
  }
 //slider list
  Future<List<SliderModel>> initValue() async {
    Future<List<SliderModel>> list = Services.getSliderJson();
    return list;
  }
  //grid view list
  Future<List<RestModel>> initGrid() async {
    Future<List<RestModel>> listGrid = Services.getJson();
    return listGrid;
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
      backgroundColor: Colors.grey.shade50,
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
                  size: const Size.square(7.0),
                  activeSize: const Size(28.0, 7.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text("Quick Meal",style: AppTheme.h2Style,),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 96.0,
              width: 96.0,
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
              child: Text("Top Restrurant",style: AppTheme.h2Style,),
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
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text("Top Meal Near You",style: AppTheme.h2Style,),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 96.0,
              width: 96.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (arrayList[index] != null) {
                    return singleTopMealView(arrayList[index]);
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
        ],
      ),
    );
  }

  //Top Restrurant

  Widget singleGridView(RestModel restModel) {
    return SizedBox(
      width: double.infinity,
      height: 125,
      child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) => ChoosePayment()));
        },
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(5.0),
          child:ClipRRect(
            borderRadius:BorderRadius.circular(15),
            child:  Column(
              children: [
                ClipRRect(
                  borderRadius:BorderRadius.circular(15),
                  child: Image(
                    image: AssetImage(restModel.icon),
                    width: double.infinity,
                    height: 120,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Text(restModel.title),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  //Top Meal Near You
  Widget singleTopMealView(SliderModel sliderModel) {
    return SizedBox(
      width: 120,
      height: 56,
      child: GestureDetector(
        onTap: (){},
        child: Card(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child:  ClipRRect(
                  borderRadius:BorderRadius.circular(5),
                  child:Image(
                    image: AssetImage(sliderModel.icon),
                    height: 34.0,
                    width: 34.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: Text(sliderModel.title,style: AppTheme.h6Style,),
              )
            ],
          ),
        ),
      ),
    );
  }
  //Meal Slidder
  Widget singleView(SliderModel sliderModel) {
    return SizedBox(
      width: 96,
      height: 56,
      child: GestureDetector(
        onTap: (){},
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(56.0)
          ),
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 12),
                child:  ClipRRect(
                  borderRadius:BorderRadius.circular(5),
                  child:Image(
                    image: AssetImage(sliderModel.icon),
                    height: 34.0,
                    width: 34.0,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(sliderModel.title,style: AppTheme.h7Style,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
