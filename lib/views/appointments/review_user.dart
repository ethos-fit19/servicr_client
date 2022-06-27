// main.dart
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:servicr_client/local.dart';

import '../../constants.dart';

class ReviewPage extends StatefulWidget {
  final String servicerId;
  final String servicerName;

  const ReviewPage(
      {Key? key, required this.servicerId, required this.servicerName})
      : super(key: key);

  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  TextEditingController reviewEditingController = new TextEditingController();
  final DateTime _reviewDate = DateTime.now();
  double? _ratingValue = 0.0;
  String review = '';
  bool isLoading = false;
  bool sended = false;

  sendReview() async {
    try {
      print('time $_reviewDate uid $uid review $review  servicer' +
          widget.servicerId +
          ' stars ' +
          _ratingValue!.round().toString());

      var response = await Dio().post(apiUrl + '/reviews', data: {
        "addedOn": _reviewDate.toString(),
        "addedby": uid,
        "review": review,
        "servicer": widget.servicerId,
        "starRating": _ratingValue!.round().toString()
      });

      print(response.data);
      return response;
    } catch (e) {
      print(e);
      return 'Unable to Fetch';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Text(
                widget.servicerName,
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Rate the service?',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 25),
              // implement the rating bar
              RatingBar(
                  initialRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  ratingWidget: RatingWidget(
                      full: const Icon(Icons.star, color: Colors.orange),
                      half: const Icon(
                        Icons.star_half,
                        color: Colors.orange,
                      ),
                      empty: const Icon(
                        Icons.star_outline,
                        color: Colors.orange,
                      )),
                  onRatingUpdate: (value) {
                    setState(() {
                      _ratingValue = value;
                    });
                  }),
              const SizedBox(height: 25),
              TextField(
                controller: reviewEditingController,
                decoration: InputDecoration(
                  labelText: 'Enter Comment',
                ),
                onChanged: (String? revText) {
                  review = revText!;
                },
              ),
              const SizedBox(height: 25),

              // Display the rate in number
              !sended
                  ? InkWell(
                      onTap: (() async {
                        setState(() {
                          isLoading = true;
                        });

                        await sendReview();
                        setState(() {
                          isLoading = false;
                          sended = true;
                        });
                      }),
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                _ratingValue != 0
                                    ? 'Rate with ' + _ratingValue.toString()
                                    : 'Rate it!',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 30),
                              ),
                      ),
                    )
                  : Container(
                      width: 200,
                      height: 200,
                      decoration: const BoxDecoration(
                          color: Colors.lightGreen, shape: BoxShape.circle),
                      alignment: Alignment.center,
                      child: isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              'Rated !',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 30),
                            ),
                    ),
            ],
          ),
        ),
      ),
    ));
  }
}
