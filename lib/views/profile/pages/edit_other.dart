import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:servicr_client/providers/currentuser_provider.dart';
import 'package:servicr_client/util/user_provider.dart';
import 'package:servicr_client/views/profile/user/user_data.dart';
import 'package:servicr_client/views/profile/widgets/appbar_widget.dart';

// This class handles the Page to edit the other Section of the User Profile.
class EditOtherFormPage extends StatefulWidget {
  @override
  _EditOtherFormPageState createState() => _EditOtherFormPageState();
}

class _EditOtherFormPageState extends State<EditOtherFormPage> {
  final _formKey = GlobalKey<FormState>();
  final OtherController = TextEditingController();
  var user = UserData.myUser;

  @override
  void dispose() {
    OtherController.dispose();
    super.dispose();
  }

  // }

  void updateUserValue(String other) async {
    final auth = UserProvider();
    user.other = other;

    // API call.
    try {
      Map body = {
        "bio": other,
      };
      var res = await auth.updateUser(
          body, context.read(currentUserProvider).state.id!);
      print(res.data);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: 350,
                      child: const Text(
                        "Other",
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      )),
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: SizedBox(
                          height: 100,
                          width: 320,
                          child: TextFormField(
                            // Handles Form Validation
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length > 300) {
                                return 'Add if you want say something about yourself';
                              }
                              return null;
                            },
                            controller: OtherController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 100,
                            minLines: 20,
                            textAlignVertical: TextAlignVertical.top,
                            decoration: const InputDecoration(
                                alignLabelWithHint: true,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 15, 10, 100),
                                hintMaxLines: 3,
                                hintText: 'Tell something'),
                          ))),
                  Padding(
                      padding: EdgeInsets.only(top: 150),
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: 320,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                // Validate returns true if the form is valid, or false otherwise.
                                if (_formKey.currentState!.validate()) {
                                  updateUserValue(OtherController.text);
                                  Navigator.pop(context);
                                }
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          )))
                ]),
          ),
        ));
  }
}

// TextFormField(
//                   //textAlignVertical: TextAlignVertical.center,
//                   controller: _body_controller,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: 100,
//                   minLines: 20,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintText: 'Type a message...',
//                       contentPadding: EdgeInsets.all(7)),
//                 );

