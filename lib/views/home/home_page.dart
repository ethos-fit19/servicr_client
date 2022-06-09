import 'package:flutter/material.dart';

import '../../constants.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home"),
      ),
      body: SingleChildScrollView(
        clipBehavior: Clip.none,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(0.0),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(9.0),
                child: SafeArea(
                  child: Container(
                    child: Image.asset(
                      'assets/images/sp_home.png',
                      width: 400.0,
                      height: 200.25,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 12.0, top: 12.0, right: 12.0, bottom: 0.0),
                child: Form(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: "Search for services",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Color.fromRGBO(225, 245, 255, 10),
                      //alignLabelWithHint:false,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(0.0)),
                        borderSide: BorderSide.none,
                        // enabledBorder:OutlineInputBorder(),
                        // focusedBorder:OutlineInputBorder(),
                      ),
                    ),
                  ),
                ),
              ),
              //const SizedBox(height:12.0,),
              SelectionTitle(
                title: "Categories",
                pressSeeAll: () {},
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 12.0, top: 0.0, right: 12.0, bottom: 0.0),
                child: Container(
                  //margin: EdgeInsets.all(2.0),
                  //color: Colors.blue,
                  height: 290,
                  //alignment: Alignment.center,
                  //width: 1000,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0.0, top: 0.0, right: 0.0, bottom: 0.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: GridView.count(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 5,
                        childAspectRatio: 1.1,
                        children: [
                          _categories(
                              image: "assets/images/I1.png",
                              name: "Electrical Repairs"),
                          _categories(
                              image: "assets/images/I2.png",
                              name: "Cleaning Service"),
                          _categories(
                              image: "assets/images/I3.png",
                              name: "Beauty & Makeup"),
                          _categories(
                              image: "assets/images/I4.png",
                              name: "Pest Control"),
                          _categories(
                              image: "assets/images/I5.png",
                              name: "Moving Service"),
                          _categories(
                              image: "assets/images/I6.png",
                              name: "Furniture Assembling"),
                        ],
                      ),
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
}

//Gridview categories
Widget _categories({
  required String image,
  required String name,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Color.fromRGBO(225, 245, 255, 10),
      borderRadius: BorderRadius.circular(2.0),
      border: Border.all(
        color: Color.fromRGBO(225, 245, 255, 10),
        width: 1,
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 12.0, top: 0.0, right: 12.0, bottom: 0.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage(image),
            )),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Text(
          name,
          style: TextStyle(fontSize: 12),
        ),
      ],
    ),
  );
}

//Categories
class SelectionTitle extends StatelessWidget {
  const SelectionTitle({
    Key? key,
    required this.title,
    required this.pressSeeAll,
  }) : super(key: key);
  final String title;
  final VoidCallback pressSeeAll;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0, bottom: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(
                  color: Color.fromRGBO(0, 33, 66, 20),
                  fontSize: 24.0,
                  fontWeight: FontWeight.w800,
                ),
          ),
          TextButton(
            onPressed: pressSeeAll,
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}