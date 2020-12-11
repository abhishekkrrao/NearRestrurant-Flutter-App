import 'package:eshop/src/model/RestModel.dart';
import 'package:eshop/src/model/Slider.dart';
import 'package:eshop/src/service/service.dart';
import 'package:flutter/material.dart';
class NearRestrurent extends StatefulWidget {
  @override
  NearRestrurentState createState() => NearRestrurentState();
}
class NearRestrurentState extends State<NearRestrurent> {
  final ScrollController _scrollController = ScrollController();
  List<RestModel> arrayListGrid;

  @override
  initState() {
    super.initState();
    initGrid().then((value) => { setState(() {
      arrayListGrid = value;
    })});
  }
  Future<List<RestModel>> initGrid() async {
    Future<List<RestModel>> listGrid = Services.getJson();
    return listGrid;
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
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding: EdgeInsets.only(left: 5),
          //     child: Text("Top Restrurent",style: TextStyle(fontSize: 21),),
          //   ),
          // ),
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                if (arrayListGrid[index] != null) {
                  return singleGridView(arrayListGrid[index]);
                }else{
                  return CircularProgressIndicator();
                }
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
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
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
    );
  }
}
