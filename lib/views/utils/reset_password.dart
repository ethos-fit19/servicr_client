import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ionicons/ionicons.dart';
import 'package:servicr_client/models/user_model.dart';
import 'package:servicr_client/views/profile/profile_page.dart';
import 'package:servicr_client/views/register/register_page.dart';
import 'package:servicr_client/views/home/landing.dart';
import 'package:servicr_client/views/welcome/welcome.dart';
import '../../local.dart';
import '../../providers/currentuser_provider.dart';
import '../../util/user_provider.dart';

class ChangePwPage extends StatefulHookWidget {
  const ChangePwPage({Key? key}) : super(key: key);

  @override
  State<ChangePwPage> createState() => _ChangePwPage();
}

class _ChangePwPage extends State<ChangePwPage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        
        title: Text("Help and support",
            style: TextStyle(
              fontSize: 22,
            )),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
       
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Save Changes",
              style: TextStyle(
                fontSize: 28,
              ),
            ),
            Column(
              children: [
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Current Password",
                    prefixIcon: Icon(Ionicons.key_outline),
                  ),
                ),

                const SizedBox(height: 20),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    prefixIcon: Icon(Ionicons.lock_closed_outline),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: passController,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    prefixIcon: Icon(Ionicons.lock_closed_outline),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 24,
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    // primary: Colors.black,
                  ),
                  onPressed: () {},
                    
              child: const Text('Login'),
                )
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}
