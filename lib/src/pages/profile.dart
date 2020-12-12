import 'package:eshop/src/model/Slider.dart';
import 'package:eshop/src/service/service.dart';
import 'package:eshop/src/themes/theme.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();
  List<SliderModel> arrayList=[];
  @override
  void initState() {
    super.initState();
    initValue().then((value) => { setState(() {arrayList = value;})});
  }
  //slider list
  Future<List<SliderModel>> initValue() async {
    Future<List<SliderModel>> list = Services.getSliderJson();
    return list;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(

          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => {Navigator.of(context).pop()},
          ),
        ),
        body: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    child: Card(
                      color: Colors.white,
                      child: logoWidget("assets/user.png"),
                      // child: logoWidget("assets/General/app.png"),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Abhishek Kumar Rao",
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "abhishekkrrao@gmail.com",
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Icon(
                                Icons.call,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "+91-7678658965",
                                  textAlign: TextAlign.start,
                                ),
                              )
                            ],
                          )),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_pin,
                              color: Colors.green,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    " Sareya Kali Sthan Ward No -4 ,GopalGanj (Bihar),In fornt of Godrej Agency ,Before Bihar Vikash Vidhyalaya.",
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                    maxLines: 5,
                                    softWrap: false,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 10,top: 10,bottom: 5),
                child: Text(
                  "Your Orders",
                  style: AppTheme.h2Style,
                ),
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
        ));
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
  //Logo
  Widget logoWidget(String path) {
    return Center(
      child: Image(
        height: 125,
        width: 125,
        image: AssetImage(path),
      ),
    );
  }
}
