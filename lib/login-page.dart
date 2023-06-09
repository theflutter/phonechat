import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String phone = "", verify = "";
  @override
  Widget build(context) {
    Controller controller = Get.put(Controller());
    controller.countryCode.text = "+91";
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/logo.jpg',
              width: 200,
              height: 200,
            ),
            SizedBox(
              width: 350,
              height: 350,
              child: Card(
                  elevation: 8,
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Container(
                    padding: EdgeInsets.all(35),
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 0, 147, 233),
                      Color.fromARGB(255, 128, 208, 199)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Phone!',
                          style: TextStyle(
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        const Text(
                          'Phone Number',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black38, width: 1))),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40,
                                child: TextField(
                                  style: const TextStyle(color: Colors.black38),
                                  controller: controller.countryCode,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              ),
                              const Text(
                                '|',
                                style: TextStyle(
                                    fontSize: 24, color: Colors.black38),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  controller: controller.phoneNumber,
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      hintText: "Enter Number",
                                      hintStyle:
                                          TextStyle(color: Colors.black38),
                                      border: InputBorder.none),
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(20),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'A 4 digit OTP will be sent via SMS to verify your mobile number!',
                          style: TextStyle(
                              color: Colors.black38,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  )),
            ),
            Container(
                width: 120,
                height: 60,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(225, 25, 167, 206)),
                    onPressed: () async {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '${controller.countryCode.text + controller.phoneNumber.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException e) {},
                        codeSent: (String verificationId, int? resendToken) {
                          LoginPage.verify = verificationId;
                          LoginPage.phone = controller.countryCode.text +
                              " " +
                              controller.phoneNumber.text;
                          Navigator.pushNamed(context, 'otp-page');
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {},
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Next',
                          style: TextStyle(fontSize: 16),
                        ),
                        Icon(Icons.arrow_right_sharp)
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
