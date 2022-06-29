//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewReview extends StatefulWidget {
  List reviews = [];
  ViewReview({required this.reviews});
  @override
  _ViewReviewState createState() => _ViewReviewState();
}

class _ViewReviewState extends State<ViewReview> {
  @override
  Widget build(BuildContext context) {
    print(widget.reviews);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Reviews"),
        ),
        body: ListView.builder(
          itemCount: widget.reviews.length,
          itemBuilder: (context, index) {
            if (widget.reviews[index]['review'] != '') {
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    'assets/images/avatar.png',
                    scale: 12,
                  ),
                  title: Column(
                    children: [
                      Text(widget.reviews[index]['addedOn']
                          .toString()
                          .substring(0, 10)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(widget.reviews[index]['review']),
                          Text(widget.reviews[index]['starRating'] + '/5')
                        ],
                      ),
                    ],
                  ),
                ),
                color: Color.fromRGBO(225, 245, 255, 10),
              );
            } else {}
            return Container();
          },
          shrinkWrap: true,
        ));
  }
}
