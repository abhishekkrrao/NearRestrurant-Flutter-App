import 'package:eshop/src/pages/More.dart';
import 'package:eshop/src/pages/login.dart';
import 'package:flutter/material.dart';
import 'NearestRest.dart';
import 'Restrurent.dart';
import 'Search.dart';
class Home extends StatefulWidget {
  final List<String> list = List.generate(10, (index) => "dominos");

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            shadowColor: Colors.green,
            backgroundColor: Colors.green,
            leading: Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(Icons.logout,color: Colors.white,),
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context)=>LoginPage()),ModalRoute.withName("login"));

                  },
                  // tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  navigateTo()
                      .then((value) => {print("value " + value)})
                      .catchError((onError) => {print("error " + onError)});
                },
                icon: Icon(Icons.search,color: Colors.white,),
              ),

            ],
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.local_cafe,color: Colors.white,)),
                Tab(icon: Icon(Icons.location_pin,color: Colors.white,)),
                Tab(icon: Icon(Icons.location_city,color: Colors.white,)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Restrurent(),
              NearRestrurent(),
              More(),
            ],
          ),
        ));
  }

  Future<dynamic> navigateTo() async {
    var result =
        await showSearch(context: context, delegate: Search(widget.list));
    print('result= ' + result);
    await result;
  }
}
