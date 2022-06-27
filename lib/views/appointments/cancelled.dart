import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:servicr_client/widgets/cancelled_list.dart';

class CancelledSp extends StatelessWidget {
  const CancelledSp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final _currentUserProvider = useProvider(currentUserProvider);
    return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Expanded(
            //   flex: 7,
            //   child: FutureBuilder(
            //     future: UserService.getAllCancelledSp(_currentUserProvider.state.id!),
            //     // future: UserService.getAllCancelledSp('0981e133-1b46-4608-befa-6f10d1ff5900'),
            //     builder: (context, snapshot) {
            //       if (snapshot.connectionState == ConnectionState.waiting) {
            //         return const CircularProgressIndicator();
            //       } else if (snapshot.hasData) {
            //         List _items = snapshot.data as List;
            //         if (_items.length == 0) {
            //           // return const Text("No any CancelledSp yet.",textAlign: TextAlign.center, style: TextStyle(fontSize: 20.0, color: Colors.yellow),);
            //            return Stack(
            //           alignment: Alignment.center,
            //           children: [
            //             Positioned(
            //                 left: 20,
            //                 top: 0,
            //                 right: 20,
            //                 child: Text('No Any CancelledSp Yet! Hurry up build your community!',
            //                   style: TextStyle(
            //                     fontSize: 20,
            //                     color: Colors.amberAccent[400],
            //                   ),
            //                   textAlign: TextAlign.center,
            //                 )),
            //             Lottie.asset('assets/anims/enjoying-sloth.json', height: MediaQuery.of(context).size.width * 0.375, width: MediaQuery.of(context).size.width * 0.375),
            //           ],
            //         );

            //         } else {
            //           return ListView.builder(
            //             itemCount: _items.length,
            //             itemBuilder: (BuildContext context, int index) {
            //               return CancelledSpListCard(index: index, userData: _items[index]);
            //             },
            //           );
            //         }
            //       } else if (snapshot.hasError) {
            //         if (snapshot.error.runtimeType == DioError) {
            //           DioError _error = snapshot.error as DioError;
            //           return Text(_error.toString());
            //         }
            //       }
            //       return const Text("Something went wrong");
            //     },
            //   ),
            // ),
            Expanded(
              flex: 7,
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return CancelledListCard(
                    index: index,
                  );
                },
              ),
            ),
          ],
        ));
  }
}
