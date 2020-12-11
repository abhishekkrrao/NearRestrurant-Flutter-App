import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => {Navigator.of(context).pop()},
        ),
      ),
      body: Container(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 120,
                child: Card(
                  color: Colors.white,
                  child: logoWidget("assets/General/app.png"),
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
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
              SizedBox(
                width: double.infinity,
                height: 80,
                child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: Colors.green,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Expanded(
                            child: Text(
                              " Sareya Kali Sthan Ward No -4 ,GopalGanj (Bihar),In fornt of Godrej Agency ,Before Bihar Vikash Vidhyalaya.",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
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
        height: 96,
        width: 96,
        image: AssetImage(path),
      ),
    );
  }
}
